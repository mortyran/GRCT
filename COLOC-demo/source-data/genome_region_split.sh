#! /bin/bash
# zcat Homo_sapiens.GRCh37.87.gff3.gz | head -500 > test.gff3
zcat Homo_sapiens.GRCh37.87.gff3.gz | awk -F "\t" 'BEGIN{OFS="\t";ORS="\n"} 
                NR>91{
                    if($0~/^###/){
                        chunk_index[ind++]=NR
                    }else{
                        file[NR] = $0
                    }
                }
                END{
                    for (i=0; i<ind-1; i++){
                        # print i
                        
                        split(file[chunk_index[i]+1], list1, "\t")
                        chr_id = list1[1]
                        start_region = list1[4]
                        
                        split(file[chunk_index[i+1]-1], list2, "\t")
                        end_region = list2[5]

                        gene_id=""
                        gene_biotype = ""
                        gene_name = ""
                        for(j = chunk_index[i]+1; j < chunk_index[i+1]-1; j++){
                            if(file[j]~/ID=gene:/){
                                if(match(file[j], /ID=gene:([^;]+)/, list3)){
                                    gene_id = list3[1]
                                }
                                if(match(file[j], /biotype=([^;]+)/, list4)){
                                    gene_biotype = list4[1]
                                }
                                if(match(file[j], /Name=([^;]+)/, list5)){
                                    gene_name = list5[1]
                                }
                            }
                        }
                        print chr_id, start_region, end_region, gene_id, gene_name, gene_biotype
                    }
                }' > gene_regions_GRCh37
