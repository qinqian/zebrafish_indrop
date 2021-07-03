sample_mapping_prl3 <- read_tsv("/data/langenau/prl3/prl3_mapping_samplecode.txt")
samples_geo_sheet <- read_tsv("/data/langenau/prl3/prl3_samples_to_geo.txt")
samples_geo_sheet %>%
  inner_join(sample_mapping_prl3, b)