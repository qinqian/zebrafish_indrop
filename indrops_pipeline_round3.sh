#python $HOME/packages/indrops/indrops.py /PHShome/si992/packages/indrops/test/indrops_v3_rep3.yaml build_index     \
#	--genome-fasta-gz /data/langenau/Danio_rerio.GRCz10.dna_sm.toplevel.fa.gz     \
#	--ensembl-gtf-gz /data/langenau/Danio_rerio.GRCz10.85.gtf.gz

# RSEM can not recognize transcript ENSDART00000000992|GTSF1!
# Gene Names with spaces in the GFT file were a problem with RSEM. So had to change (1 of many) to _1_of_many in GTF, gzip it and recreate index
#python $HOME/packages/indrops/indrops.py /PHShome/si992/packages/indrops/test/indrops_v3_rep3.yaml build_index     \
#        --genome-fasta-gz /data/langenau/Danio_rerio.GRCz10.dna_sm.toplevel.fa.gz     \
#        --ensembl-gtf-gz /data/langenau/Danio_rerio.GRCz10.85.gtf.quoted_genenames.gz


# Round 2 of index building. Noticed that indrops.py was throwing out a lot of biotypes that were of interest to us. So changed that, reran indexing; reran counting
# STEP 0 - ONE TIME ONLY
#python $HOME/packages/indrops/indrops.py /PHShome/si992/packages/indrops/test/indrops_v3_rep3.yaml build_index     \
#        --genome-fasta-gz /data/langenau/Danio_rerio.GRCz10.dna_sm.toplevel.fa.gz     \
#        --ensembl-gtf-gz /data/langenau/Danio_rerio.GRCz10.85.gtf.quoted_genenames.gz


# STEP 1
for library in {"WT_rep3","rag2_rep3","rag2il2rga_rep3"}
do
        for worker_index in {0..19}
        do
		bsub -q big-multi -o $HOME/RECYCLE_BIN/filter_worker_${library}.${worker_index}.%J.log python $HOME/packages/indrops/indrops.py /data/langenau/yan_indrop/indrops_v3_rep3.yaml filter --libraries ${library} --total-workers 20 --worker-index ${worker_index}
	done
done

# STEP 1 done wihout parallelization
bsub -q big-multi -o $HOME/RECYCLE_BIN/filter.%J.log python $HOME/packages/indrops/indrops.py /data/langenau/yan_indrop/indrops_v3_rep3.yaml filter

# STEP 2
module load gcc/7.1.0
python $HOME/packages/indrops/indrops.py /data/langenau/yan_indrop/indrops_v3_rep3.yaml identify_abundant_barcodes
grep -c "\-" ./*/abundant_barcodes.pickle


# STEP 3
for library in {"WT_rep3","rag2_rep3","rag2il2rga_rep3"}
do
        for worker_index in {0..19}
        do
		bsub -q big-multi -o $HOME/RECYCLE_BIN/sort_worker_${library}_${worker_index}.log python $HOME/packages/indrops/indrops.py /data/langenau/yan_indrop/indrops_v3_rep3.yaml sort --libraries ${library} --total-workers 20 --worker-index ${worker_index}
	done
done


# Had to use samtools/1.3.1 for samtools sort to work without changing code in indrops.py. Changed setting in /PHShome/si992/packages/indrops/test/indrops_v3_rep3.yaml
# module load samtools/1.3.1; which samtools;/apps/lib-osver/samtools/1.3.1/bin/. But this did not work!! 
# So I had to install samtools 1.3.1 in my home directory, change setting again in the yaml file to /PHShome/si992/packages/samtools-1.3.1/ and rerun
# STEP 4
for library in {"WT_rep3","rag2_rep3","rag2il2rga_rep3"}
do
        for worker_index in {0..19}
        do
                bsub -q big-multi -o $HOME/RECYCLE_BIN/quantify_worker_${library}_${worker_index}.log python $HOME/packages/indrops/indrops.py /data/langenau/yan_indrop/indrops_v3_rep3.yaml quantify --min-reads 1000 --no-bam --min-counts 1 --analysis-prefix yan_indrop --libraries ${library} --total-workers 20 --worker-index ${worker_index}
        done
done


# STEP 5
for library in {"WT_rep3","rag2_rep3","rag2il2rga_rep3"}
do
	python $HOME/packages/indrops/indrops.py /data/langenau/yan_indrop/indrops_v3_rep3.yaml aggregate --analysis-prefix yan_indrop  --no-bam --libraries ${library}
done
