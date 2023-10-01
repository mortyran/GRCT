# /bin/bash
source activate ldsc
./ldsc.py \
--rg /data/ever_smoke_gss_ldsc_input.sumstats.gz,/data/asthma_gss_ldsc_input.sumstats.gz \
--ref-ld-chr /data/eur_w_ld_chr/ \
--w-ld-chr /data/eur_w_ld_chr/ \
--out /data/genetic_correlation_e2a

./ldsc.py \
--rg /data/ever_smoke_gss_ldsc_input.sumstats.gz,/data/lung_cancer_gss_ldsc_input.sumstats.gz \
--ref-ld-chr /data/eur_w_ld_chr/ \
--w-ld-chr /data/eur_w_ld_chr/ \
--out /data/genetic_correlation_e2l

./ldsc.py \
--rg /data/asthma_gss_ldsc_input.sumstats.gz,/data/lung_cancer_gss_ldsc_input.sumstats.gz \
--ref-ld-chr /data/eur_w_ld_chr/ \
--w-ld-chr /data/eur_w_ld_chr/ \
--out /data/genetic_correlation_a2l