#cd /data/langenau/yan_indrop/189492315/
#/PHShome/si992/packages/bcl2fastq2-v2.17.1.x/bin/bcl2fastq -d 4 --use-bases-mask y*,y*,y*,y* --mask-short-adapter-reads 0 --minimum-trimmed-read-length 0 
#mv /data/langenau/yan_indrop/189492315/Data/Intensities/BaseCalls/*fastq.gz /data/langenau/yan_indrop/fastq/

cd /data/langenau/yan_indrop/191494361/
/PHShome/si992/packages/bcl2fastq2-v2.17.1.x/bin/bcl2fastq -d 4 --use-bases-mask y*,y*,y*,y* --mask-short-adapter-reads 0 --minimum-trimmed-read-length 0 
mv /data/langenau/yan_indrop/191494361/Data/Intensities/BaseCalls/*fastq.gz /data/langenau/yan_indrop/fastq_191494361

cd /data/langenau/yan_indrop/189484327/
/PHShome/si992/packages/bcl2fastq2-v2.17.1.x/bin/bcl2fastq -d 4 --use-bases-mask y*,y*,y*,y* --mask-short-adapter-reads 0 --minimum-trimmed-read-length 0 
mv /data/langenau/yan_indrop/189484327/Data/Intensities/BaseCalls/*fastq.gz /data/langenau/yan_indrop/fastq_189484327
