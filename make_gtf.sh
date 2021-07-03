/PHShome/si992/packages/bioawk/bioawk -c fastx '{ print $name"\t"length($seq)}'  /data/langenau/ball_tall/receptors/seqs/TCR_colors_mappingSet.fa > /data/langenau/alex_indrops_ball_tall/TCR_colors_mappingset_names_and_lengths.txt

while read lineall
do
	seqname=`echo ${lineall} | awk '{ print $1}'`
	seqlength=`echo ${lineall} | awk '{ print $2}'`
	printf "${seqname}	external	gene	1	${seqlength}	.	-	.	gene_id "${seqname}"; gene_version "1"; gene_name "${seqname}"; gene_source "external"; gene_biotype "external";
${seqname}	external	transcript	1	${seqlength}	.	-	.	gene_id "${seqname}"; gene_version "1"; transcript_id "${seqname}_01"; transcript_version "1"; gene_name "${seqname}"; gene_source "external"; gene_biotype "external"; transcript_name "${seqname}.1-201"; transcript_source "external"; transcript_biotype "external";
${seqname}	external	exon	1	${seqlength}	.	-	.	gene_id "${seqname}"; gene_version "1"; transcript_id "${seqname}_01"; transcript_version "1"; exon_number "1"; gene_name "${seqname}"; gene_source "external"; gene_biotype "external"; transcript_name "${seqname}.1-201"; transcript_source "external"; transcript_biotype "external"; exon_id "${seqname}_exon1"; exon_version "1";
" >> /data/langenau/alex_indrops_ball_tall/Danio_rerio.GRCz10.dna_sm.toplevel_with_mouseMYC_colors_receptors.gtf
done < /data/langenau/alex_indrops_ball_tall/TCR_colors_mappingset_names_and_lengths.txt

# Manually removed T and B variable and constant regions
