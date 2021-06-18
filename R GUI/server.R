VaR.MC=function(x,Wo=1,n=1000,alpha=c(0.01,0.025,0.05,0.1),k=1) 
{
  x=as.matrix(x)
  n.data=dim(x)[1]
  
  Mean.Rt=mean(x)
  Sigma.Rt=sd(x)
  return.sim=rnorm(n,Mean.Rt,Sigma.Rt)  
  Rbintang=quantile(return.sim,alpha) 
  VaR=Wo*Rbintang*sqrt(k)
  tampilan=as.matrix(t(VaR))
  colnames(tampilan)=paste(((1-alpha)*100),"%",sep="")
  rownames(tampilan)=""
  return(tampilan)
  
}

VaR_MC=function(x,m,Wo)
{
  VaR.MC=matrix(NA,m,4)
  for(i in 1:m)
  {
    VaR.MC[i,1]=VaR.MC(x,Wo)[1]
    VaR.MC[i,2]=VaR.MC(x,Wo)[2]
    VaR.MC[i,3]=VaR.MC(x,Wo)[3]
    VaR.MC[i,4]=VaR.MC(x,Wo)[4]
  }
  VaR.MC
  y=colMeans(VaR.MC)
  rata2=as.matrix(t(y))
  cat("=================================================================","\n") 
  cat("Nilai VaR dengan Simulasi Monte Carlo untuk tingkat kepercayaan : \n")
  cat("=================================================================","\n")
  cat("     99%     97.5%     95%     90%     \n")
  cat("=================================================================","\n")
  print(VaR.MC)
  colnames(rata2)=paste(((1-c(0.01,0.025,0.05,0.1))*100),"%",sep="")
  rownames(rata2)=""
  cat("=================================================================","\n")
  cat("Rata-rata nilai VaR dengan",m,"kali ulangan untuktingkat kepercayaan : \n")
  return(rata2)
}

server <- function(input, output) {
  output$tsplot<-renderPlot({
    data<-input$data
    if(is.null(data)){return()}
    file<-read.csv(data$datapath,header = T ,sep ='\t')
    x<-file[,1]
    ts.plot(x,main="Harga Penutupan",col="red",xlab="periode",ylab="data")
  })
  output$deskriptif<-renderPrint({
    data<-input$data
    if(is.null(data)){return()}
    file<-read.csv(data$datapath,header = T ,sep ='\t')
    x<-file[,1]
    cat("=======================\n")
    cat("statistik deskriptif\n")
    cat("=======================\n")
    cat("rata-rata=",mean(x),"\n")
    cat("variansi=",var(x),"\n")
    cat("maksimum=",max(x),"\n")
    cat("minimum=",min(x),"\n")
    cat("=======================\n")
  })
  output$data<-renderPrint({
    data<-input$data
    if(is.null(data)){return()}  
    file<-read.csv(data$datapath,header = T ,sep ='\t')
    x<-file[,1]
    saham=matrix(x,ncol=1)
    cat("=======================\n")
    cat("Harga Penutupan\n")
    cat("=======================\n")
    print(saham)
    cat("=======================\n")
    
  })
  output$ret<-renderPrint({
    data<-input$data
    if(is.null(data)){return()}
    file<-read.csv(data$datapath,header = T ,sep ='\t')
    x<-file[,1]
    n=length(x)
    ret_saham=rep(0,n-1)
    for(i in 2:n)
    {
      ret_saham[i]=log(x[i]/x[i-1])
    }
    retsaham=matrix(ret_saham,ncol=1)
    cat("=======================\n")
    cat("data return saham\n")
    cat("=======================\n")
    print(retsaham)
    cat("=======================\n")
  })
  output$normalitas<-renderPrint({
    data<-input$data
    if(is.null(data)){return()}
    file<-read.csv(data$datapath,header = T ,sep ='\t')
    x<-file[,1]
    n=length(x)
    ret_saham=rep(0,n-1)
    for(i in 2:n)
    {
      ret_saham[i]=log(x[i]/x[i-1])
    }
    retsaham=matrix(ret_saham,ncol=1)
    cat("=============================\n")
    cat("uji normalitas return\n")
    cat("=============================\n")
    ks=ks.test(retsaham, "pnorm")
    print(ks)
    cat("=============================\n")
    cat("Hipotesis\n")
    cat("H0: return berdistribusi normal\n")
    cat("H1: return tidak berdistribusi normal\n")
    cat("daerah kritis: tolak H0 jika p-value<0.05\n")
    cat("statistik uji: nilai p-value=",ks$p.value,"\n")
    if(ks$p.value<0.05){
      cat("kesimpulan: return tidak berdistribusi normal\n")}
    else{cat("kesimpulan: return berdistribusi normal\n")}
  })
  observeEvent(input$hitung1,{
    data<-input$data
    if(is.null(data)){return()}
    file<-read.csv(data$datapath,header = T ,sep ='\t')
    x<-file[,1]
    n=length(x)
    ret_saham=rep(0,n-1)
    for(i in 2:n)
    {
      ret_saham[i]=log(x[i]/x[i-1])
    }
    Wo<-as.numeric(input$w)
    m<-as.numeric(input$N)
    output$VAR<-renderPrint({VaR_MC(ret_saham,m,Wo)})
    output$interpretasi<-renderPrint({
      cat("nilai rata-rata VaR diatas sesuai dengan tingkat kepercayaan dan pengulangan yang anda input menunjukan kerugian maksimal dalamsatu periode kedepan\n")})
  })
}
