// Bilateral Filter C fast implementation for MATLAB , modified version from matlab

#include "mex.h"
#include <math.h>
#include <string.h>
#include <stdio.h>

#define ABS(A) ((A)>0?A:(-(A)))
#define MAX(A,B) ((A)>(B)?(A):(B))
#define MIN(A,B) ((A)>(B)?(B):(A))

/* bilateral filter mex function*/
void mexFunction(int nlhs, mxArray *plhs[ ],int nrhs, const mxArray *prhs[ ])
{
 
    double * in_red,*in_green,*in_blue;
   
    double * RadialDomainWeights;
    
    double * IntensityRangeWeightsRed,* IntensityRangeWeightsGreen,* IntensityRangeWeightsBlue;

    double value,red_value,green_value,blue_value;
    
    /*Output image*/
    double * out_red,* out_green,* out_blue;
    
    /*size  of the image*/
    double * pDimI;
    double * pDimJ;
    
    double DimI,DimJ;
    
    /* sigma_d for domain, sigma_r for range*/
    double * psigma_d,* psigma_r;
    
    double sigma_d,sigma_r;

    
    /*Half width of the parsing window*/
    double * pw;
    double w;
    
    double k;
    
    int i,j,ii,jj;
    
    int iMin,iMax,jMin,jMax;
    
    double red_num,green_num,blue_num,denom;
    
    
    double red_index_ij,green_index_ij,blue_index_ij;
    double red_index_iijj,green_index_iijj,blue_index_iijj;
    
    double t;
    
    in_red=mxGetPr(prhs[0]);
    in_green=mxGetPr(prhs[1]);
    in_blue=mxGetPr(prhs[2]);
    
    pDimI=mxGetPr(prhs[3]);
    DimI=pDimI[0];
    
    pDimJ=mxGetPr(prhs[4]);
    DimJ=pDimJ[0];
    
    psigma_d=mxGetPr(prhs[5]);
    sigma_d=psigma_d[0];
    
    psigma_r=mxGetPr(prhs[6]);
    sigma_r=psigma_r[0];
    
    pw=mxGetPr(prhs[7]);
    w=pw[0];
    
    
   
    /* Output Memory allocation*/
    plhs[0] = mxCreateDoubleMatrix((int)(DimI*DimJ),1,mxREAL);
    out_red = mxGetPr(plhs[0]);
    
    
    plhs[1] = mxCreateDoubleMatrix((int)(DimI*DimJ),1,mxREAL);
    out_green = mxGetPr(plhs[1]);
    
    plhs[2] = mxCreateDoubleMatrix((int)(DimI*DimJ),1,mxREAL);
    out_blue = mxGetPr(plhs[2]);
    
    
        /* Radial domain weights*/
    plhs[3] = mxCreateDoubleMatrix((int)(2*w*w*4),1,mxREAL);
    RadialDomainWeights = mxGetPr(plhs[3]);
    for (i=0;i<2*w*w*4;i++){
        RadialDomainWeights[(int)(i)]=exp(-0.5*i/(sigma_d*sigma_d));
    }
    
    plhs[4] = mxCreateDoubleMatrix((int)(1024),1,mxREAL);
    IntensityRangeWeightsRed = mxGetPr(plhs[4]);
    for (i=0;i<1024;i++){
        IntensityRangeWeightsRed[(int)(i)]=exp(-0.5*(i*i)/(sigma_r*sigma_r));
    }

    plhs[5] = mxCreateDoubleMatrix((int)(1024),1,mxREAL);
    IntensityRangeWeightsGreen = mxGetPr(plhs[5]);
    for (i=0;i<1024;i++){
        IntensityRangeWeightsGreen[(int)(i)]=exp(-0.5*(i*i)/(sigma_r*sigma_r));
    }

    plhs[6] = mxCreateDoubleMatrix((int)(1024),1,mxREAL);
    IntensityRangeWeightsBlue = mxGetPr(plhs[6]);
    for (i=0;i<1024;i++){
        IntensityRangeWeightsBlue[(int)(i)]=exp(-0.5*(i*i)/(sigma_r*sigma_r));
    }

    k=0;
    
    for (i=0;i<DimI;i++){
        for (j=0;j<DimJ;j++){
            
            iMin = MAX((double)i-w,(double)0.0);
            iMax = MIN((double)i+w,(double)DimI);
            jMin = MAX((double)j-w,(double)0.0);
            jMax = MIN((double)j+w,(double)DimJ);
            
            red_num=0;
            green_num=0;
            blue_num=0;
            denom=0;
            t=0;
            red_index_ij=in_red[(int)(i*DimJ+j)];
            green_index_ij=in_green[(int)(i*DimJ+j)];
            blue_index_ij=in_blue[(int)(i*DimJ+j)];
            for (ii=iMin;ii<iMax;ii++){
                for (jj=jMin;jj<jMax;jj++){
                    if(!((ii==i) && (jj==j))){
                        
                        
                        red_index_iijj=in_red[(int)(ii*DimJ+jj)];
                        green_index_iijj=in_green[(int)(ii*DimJ+jj)];
                        blue_index_iijj=in_blue[(int)(ii*DimJ+jj)];
                        
                        value=(i-ii)*(i-ii)+(j-jj)*(j-jj);
                        
                        red_value=ABS( red_index_ij - red_index_iijj ); 
                        green_value=ABS( green_index_ij - green_index_iijj );
                        blue_value=ABS( blue_index_ij - blue_index_iijj );
                        
                        t=RadialDomainWeights[(int)( value )]*IntensityRangeWeightsRed[(int)(red_value)]*IntensityRangeWeightsGreen[(int)(green_value)]*IntensityRangeWeightsBlue[(int)(blue_value)];
                                                
                        red_num=red_num+red_index_iijj*t;
                        green_num=green_num+green_index_iijj*t;
                        blue_num=blue_num+blue_index_iijj*t;
                        denom=denom+t;
                    }
                }
            }
            
            if (!(denom==0)){
                out_red[(int)(k)]=red_num/denom;
                out_green[(int)(k)]=green_num/denom;
                out_blue[(int)(k)]=blue_num/denom;
            }
            else{
                out_red[(int)(k)]=in_red[(int)(k)];
                out_green[(int)(k)]=in_green[(int)(k)];
                out_blue[(int)(k)]=in_blue[(int)(k)];
            }
            k=k+1;
        }
    }
    
}


