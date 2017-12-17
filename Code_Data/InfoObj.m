//
//  InfoObj.m
//  GIS2010
//
//  Created by Carlo Macor on 03/03/10.
//  Copyright 2010 Carlo Macor. All rights reserved.
//

#import "InfoObj.h"
#import "funzioni.h"


@implementation InfoObj

//	double  xcorr      =    0;	double  ycorr      =   0;  // vuoto

@synthesize  numVtCorAdded ;
@synthesize	 offsetCxfX;
@synthesize  offsetCxfY;
@synthesize  scalaDisGoogleno;


- (void) initInfo  {
		//	varbase   = _varbase;
	offxroma=  -69;   
	offyroma=  -192;
	offxGoogleMaps =0;   // correzioni legate al comune specie se montano
	offyGoogleMaps =0;
	scalaDisGoogleno = 9.0;

	
	dimMirino=10;

	[self set_scalaVista:1.0];
	[self set_dimMirino:dimMirino];
	[self update_offsetmirino];
	[self setlat_centrogoogle_w:42.15000 ];
	[self setlon_centrogoogle_w:11.45800 ];
		//	[self setZoomAll];
	[self setrasterautosave:NO];
		//	[self setgoogle_maxscala:20]; il 20 e' veramente il massimale
	[self setgoogle_maxscala:18];  
	[self set_origineVista: 2251924.0 :4682612.0];
	[self calcola];
	
		//	VedoVerticiTuttoDisegno =YES;
	VedoVerticiTuttoDisegno = NO;
	offsetCxfX=0;
	offsetCxfY=0;
	instampa = NO;
	
}

@synthesize  instampa ;


- (void) setoffxGoogleMaps : (double) ofx {
	offxGoogleMaps = ofx;
}

- (void) setoffyGoogleMaps : (double) ofy {
	offyGoogleMaps = ofy;
}
- (void) setoffcxfx: (double) valx  {
	offsetCxfX = valx;
}

- (void) setoffcxfy: (double) valy  {
	offsetCxfY = valy;
}


- (void)   setpdf   : (PDFView *) _pdf{
	Info_mypdf = _pdf;
}

- (PDFView *)   pdf                   {
	return Info_mypdf;
}


// limiti del disegno RASTER corrente
-(double)  limx1DisR        { return d_limx1DisR;  }	
-(double)  limy1DisR        { return d_limy1DisR;  }		
-(double)  limx2DisR        { return d_limx2DisR;  }	
-(double)  limy2DisR        { return d_limy2DisR;  }	

// limiti del singolo Raster corrente
-(double)  limx1Ras         { return d_limx1Ras;   }	
-(double)  limy1Ras         { return d_limy1Ras;   }	
-(double)  limx2Ras         { return d_limx2Ras;   }	
-(double)  limy2Ras         { return d_limy2Ras;   }	

// limiti del disegno VETTORIALE corrente
-(double)  limx1DisV        { return d_limx1DisV;  }	
-(double)  limy1DisV        { return d_limy1DisV;  }	
-(double)  limx2DisV        { return d_limx2DisV;  }	
-(double)  limy2DisV        { return d_limy2DisV;  }	

// limiti del singolo PIANO corrente
-(double)  limx1Piano       { return d_limx1Piano; }	
-(double)  limy1Piano       { return d_limy1Piano; }	
-(double)  limx2Piano       { return d_limx2Piano; }	
-(double)  limy2Piano       { return d_limy2Piano; }	

// limiti del TUTTO
-(double)  limx1Tutto       { return d_limx1Tutto; }	
-(double)  limy1Tutto       { return d_limy1Tutto; }	
-(double)  limx2Tutto       { return d_limx2Tutto; }	
-(double)  limy2Tutto       { return d_limy2Tutto; }	

// le viste schermo e riquadratini raster vector
-(double)  scalaVista                          { return d_scalaVista;     }
-(double)  xorigineVista                       { return d_xorigineVista;  }
-(double)  yorigineVista                       { return d_yorigineVista;  }
-(double)  x2origineVista                      { return d_x2origineVista; }
-(double)  y2origineVista                      { return d_y2origineVista; }
-(double)  dimxVista                           { return d_dimxView;       }
-(double)  dimyVista                           { return d_dimyView;       }


// snap
-(double)  xsnap                               { return xsnap; }
-(double)  ysnap                               { return ysnap; }
-(double)  give_offsetmirino                   { return offsetmirino;  }

// spline utility
-(int)     i_xlastspline                       { return i_xlastspline;  }
-(int)     i_ylastspline                       { return i_ylastspline;  }

- (bool)   rasterautosave                      {
	return b_rasterautosave;
}



- (void)   setrasterautosave: (bool) Stato     {
	b_rasterautosave = Stato;
}


// GoogleMap

-(int)     google_maxscala                     { return google_maxscala;   }
-(float)   lat_centrogoogle_w                  { return lat_centrogoogle_w;  }
-(float)   lon_centrogoogle_w                  { return lon_centrogoogle_w;  }
-(float)   lat_centrogoogle_r                  { return lat_centrogoogle_r;  }
-(float)   lon_centrogoogle_r                  { return lon_centrogoogle_r;  }
-(double)  N_centrogoogle                      { return N_centrogoogle;    }
-(double)  E_centrogoogle                      { return E_centrogoogle;    }
-(float)   scalaVista_g                        { return f_scalaVista_g;     }

// settaggio dei limiti
- (void)   setLimitiTutto   : (double) _x1 : (double) _y1 :(double) _x2 :(double) _y2         {
	d_limx1Tutto=_x1;		d_limx2Tutto=_x2;		d_limy1Tutto=_y1;		d_limy2Tutto=_y2;  
}
- (void)   setLimitiDisR    : (double) _x1 : (double) _y1 :(double) _x2 :(double) _y2         {
	d_limx1DisR=_x1;		d_limx2DisR=_x2;		d_limy1DisR=_y1;		d_limy2DisR=_y2;  
}
- (void)   setLimitiRas     : (double) _x1 : (double) _y1 :(double) _x2 :(double) _y2         {
	d_limx1Ras=_x1;		    d_limx2Ras=_x2;		    d_limy1Ras=_y1;		    d_limy2Ras=_y2;  
}
- (void)   setLimitiDisV    : (double) _x1 : (double) _y1 :(double) _x2 :(double) _y2         {
	d_limx1DisV=_x1;		d_limx2DisV=_x2;		d_limy1DisV=_y1;		d_limy2DisV=_y2;  
}
- (void)   setLimitiPiano   : (double) _x1 : (double) _y1 :(double) _x2 :(double) _y2         {
	d_limx1Piano=_x1;		d_limx2Piano=_x2;		d_limy1Piano=_y1;		d_limy2Piano=_y2;  
}

// attuazzione degli zoom
- (void)   setZoomAll                                                                         {
	d_xorigineVista = d_limx1Tutto;
	d_yorigineVista = d_limy1Tutto;
	double dx; double dy; double d_scal;
	dx              = d_limx2Tutto-d_limx1Tutto;
	dy              = d_limy2Tutto-d_limy1Tutto;
    d_scalaVista    = dx/d_dimxView;
    d_scal          = dy/d_dimyView;
	[self set_scalaVista2:d_scalaVista : d_scal];
	[self setZoomC    : ((d_limx1Tutto+d_limx2Tutto)/2)  : ((d_limy1Tutto+d_limy2Tutto)/2)  ];
}

- (void)   setZoomC          : (double) newx: (double) newy                                   {
	double dx;  double dy; 
	dx =     d_scalaVista*d_dimxView; 
    dy =     d_scalaVista*d_dimyView; 
	d_xorigineVista = newx-dx/2;
	d_yorigineVista = newy-dy/2;
	[self riaggiornax2y2];

}

- (void)   setZoomAllRaster                                                                   {
	if (d_limx1DisR==d_limx2DisR) return;
	d_xorigineVista = d_limx1DisR;
	d_yorigineVista = d_limy1DisR;
	double dx; double dy; double d_scal;
	dx              = d_limx2DisR-d_limx1DisR;
	dy              = d_limy2DisR-d_limy1DisR;
    d_scalaVista    = dx/d_dimxView;
    d_scal          = dy/d_dimyView;
	[self set_scalaVista2:d_scalaVista : d_scal];
	[self setZoomC    : ((d_limx1DisR+d_limx2DisR)/2)  : ((d_limy1DisR+d_limy2DisR)/2)  ];

}
- (void)   setZoomLocRaster                                                                   {
	if (d_limx1Ras==d_limx2Ras) return;
	d_xorigineVista = d_limx1Ras;  	    d_yorigineVista = d_limy1Ras;
	double dx; double dy; double d_scal;
	dx              = d_limx2Ras-d_limx1Ras;
	dy              = d_limy2Ras-d_limy1Ras;
    d_scalaVista    = dx/d_dimxView;
    d_scal          = dy/d_dimyView;
	[self set_scalaVista2:d_scalaVista : d_scal];
	[self setZoomC    : ((d_limx1Ras+d_limx2Ras)/2)  : ((d_limy1Ras+d_limy2Ras)/2)  ];

}
- (void)   setZoomAllVector                                                                   {
	if (d_limx1DisV==d_limx2DisV) return;
	d_xorigineVista = d_limx1DisV;
	d_yorigineVista = d_limy1DisV;
	double dx; double dy; double d_scal;
	dx              = d_limx2DisV-d_limx1DisV;
	dy              = d_limy2DisV-d_limy1DisV;
    d_scalaVista    = dx/d_dimxView;
    d_scal          = dy/d_dimyView;
	[self set_scalaVista2:d_scalaVista : d_scal];
	[self setZoomC    : ((d_limx1DisV+d_limx2DisV)/2)  : ((d_limy1DisV+d_limy2DisV)/2)  ];

}
- (void)   setZoomPianoVector                                                                 {
	if (d_limx1Piano==d_limx2Piano) return;
	d_xorigineVista = d_limx1Piano;          
	d_yorigineVista = d_limy1Piano;
	double dx; double dy; double d_scal;
	dx              = d_limx2Piano-d_limx1Piano;
	dy              = d_limy2Piano-d_limy1Piano;
    d_scalaVista    = dx/d_dimxView;
    d_scal          = dy/d_dimyView;
	[self set_scalaVista2:d_scalaVista : d_scal];
	[self setZoomC    : ((d_limx1Piano+d_limx2Piano)/2)  : ((d_limy1Piano+d_limy2Piano)/2)  ];
}

// settaggio vista corrente
- (void)   set_scalaVista   :(double) value                                                   {
	d_scalaVista   = value;
	f_scalaVista_g = d_scalaVista*scalaDisGoogleno;  // ex 9.0 di Allumiere
	[self riaggiornax2y2];
}
- (void)   set_scalaVista2 : (double) value1: (double) value2                                 {
	double value=value1;
	if (value2>value1) value=value2;
	if (value==0) value=1.0;
	[self set_scalaVista:value]; 
}

- (void)   set_origineVista :(double) _vx  : (double) _vy                                     {
	d_xorigineVista=_vx;
	d_yorigineVista=_vy;
	[self riaggiornax2y2];

}

- (void)   set_origineVistax: (double) _vx {
	d_xorigineVista=_vx;
	[self riaggiornax2y2];

}

- (void)   set_origineVistay: (double) _vy {
	d_yorigineVista=_vy;
	[self riaggiornax2y2];

}


- (void)   set_dimVista     :(double) _vx  : (double) _vy                                     {
	d_dimxView=_vx;
	d_dimyView=_vy;
	[self riaggiornax2y2];
}

- (void)   riaggiornax2y2                                                                     {
	d_x2origineVista = d_xorigineVista + d_dimxView*d_scalaVista;
	d_y2origineVista = d_yorigineVista + d_dimyView*d_scalaVista;
}

- (NSString *)  fusoStr                                                                       {
	NSString * str;
	str =@"";  str = [str stringByAppendingFormat:	 @"%d°",1];
	return str;
}


// set snap
- (void)   setxysnap        :(double) xsn  : (double) ysn                                     { xsnap=xsn; ysnap=ysn; }
- (void)   set_dimMirino    :(int)dimMir                                                      { dimmirino=dimMir; }
- (void)   update_offsetmirino                                                                { offsetmirino = (double)dimmirino*d_scalaVista; }

// spline uyility
- (void)   set_xylastspline : (int) _x : (int) _y                                             {
	i_xlastspline = _x;	i_ylastspline = _y;
}

// set GoogleMap
- (void)   setgoogle_maxscala:(int) _valmax                                                   {	google_maxscala=_valmax;  }
- (void)   setlat_centrogoogle_w:(float) _vallat                                              { lat_centrogoogle_w=_vallat; }
- (void)   setlon_centrogoogle_w:(float) _vallon                                              { lon_centrogoogle_w=_vallon; }
- (void)   setlat_centrogoogle_r:(float) _vallat                                              { lat_centrogoogle_r=_vallat; }
- (void)   setlon_centrogoogle_r:(float) _vallon                                              { lon_centrogoogle_r=_vallon; }
- (void)   setN_centrogoogle:(double) _val                                                    { N_centrogoogle = _val;    }
- (void)   setE_centrogoogle:(double) _val                                                    { E_centrogoogle = _val;    }
- (void)   calcola                                                                            {
	double  centro_x, centro_y;
	
	
	centro_x = d_xorigineVista+d_dimxView*d_scalaVista/2.0;
	centro_y = d_yorigineVista+d_dimyView*d_scalaVista/2.0;
    
        // patch specifica del comune
    centro_x = centro_x + offxGoogleMaps;
    centro_y = centro_y + offyGoogleMaps;

	
    
	[self utmtolatlon  :  &centro_x : &centro_y ]; 
	lat_centrogoogle_w = centro_y;	
	lon_centrogoogle_w = centro_x;
	
		//		NSLog(@"C %2.4f %2.4f",lon_centrogoogle_w,lat_centrogoogle_w);

	double  centro_x1, centro_y1;

	centro_x1 = d_xorigineVista;
	centro_y1 = d_yorigineVista;
		// updated
	centro_x1 = d_xorigineVista;
	centro_y1 = d_yorigineVista+d_dimyView*d_scalaVista/2;
	[self utmtolatlon  :  &centro_x1 : &centro_y1 ]; 
	N_1google = centro_y1;	
	E_1google = centro_x1;

	double  centro_x2, centro_y2;

	centro_x2 = d_xorigineVista+d_dimxView*d_scalaVista;
	centro_y2 = d_yorigineVista;
		// updated
	centro_x2 = d_xorigineVista+d_dimxView*d_scalaVista;
	centro_y2 = d_yorigineVista+d_dimyView*d_scalaVista/2;
	
	[self utmtolatlon  :  &centro_x2 : &centro_y2 ]; 
	N_2google = centro_y2;	
	E_2google = centro_x2;

	
	
}



- (double)  N_1google              { return N_1google; }	    
- (double)  E_1google              { return E_1google; }
- (double)  N_2google              { return N_2google; }
- (double)  E_2google              { return E_2google; }



- (void) utmtocatasto   : (double*) xcord : (double*) ycord        {

	*xcord = *xcord-offsetCxfX;
	*ycord = *ycord-offsetCxfY;
	
		// centro di rotazione civitavecchia piazzola aurelia
	double angrot = 0.02959;
	double xc = 2254082;	double yc = 4670053;
	
	double locx,locy;
	*xcord =*xcord-xc;            	*ycord =*ycord-yc;
	locx = *xcord * cos(angrot) - *ycord*sin(angrot);        	
	locy = *xcord * sin(angrot) + *ycord*cos(angrot);
	*xcord =locx+xc;            	 *ycord =locy+yc;
	*xcord =*xcord-(2309451.4);   	 *ycord =*ycord-(4646172); 	  

}


- (void) catastotoutm : (double*) xcord : (double*) ycord {
		// centro di rotazione civitavecchia piazzola aurelia
	
	double angrot = 0.02959;
	double xc = 2254082;	double yc = 4670053;
	if (*xcord >1000000) { // in Gauss Boaga !! ?? o Wgs84 ??
		*xcord= *xcord-8;  // immotivato offset del catasto
		*ycord= *ycord-11;
	}
	else {  // cassini-Soldner
		*xcord =*xcord+(2309451.4);   	 *ycord =*ycord+(4646172); 	  
		*xcord =*xcord-xc;            	 *ycord =*ycord-yc;
		double locx,locy;
		locx = *xcord * cos(-angrot) - *ycord*sin(-angrot);        	
		locy = *xcord * sin(-angrot) + *ycord*cos(-angrot);
		*xcord =locx+xc;            	*ycord =locy+yc;
	}
	
	*xcord = *xcord+offsetCxfX;
	*ycord = *ycord+offsetCxfY;
		//	NSLog(@"-- %1.2f -- %1.2f",offsetCxfX,offsetCxfY);
}


- (bool) VedoVerticiTuttoDisegno {
	return VedoVerticiTuttoDisegno;
}

- (void) setVedoVerticiTuttoDisegno : (bool) modo {
	VedoVerticiTuttoDisegno = modo;
}

- (void) switchsetVedoVerticiTuttoDisegno {
	VedoVerticiTuttoDisegno = !VedoVerticiTuttoDisegno;
}



- (void) traformacord : (double*) xcord : (double*) ycord : (int) Proiezione {
	switch (Proiezione) {
		case 0 :			                                  break; // UTM WGS84
		case 1 : [self utmtolatlon   :   xcord :  ycord ]; 	  break; // globo WGS84
		case 2 : [self utmtoutm50    :   xcord :  ycord ];    break; // qui la modifica tra wgs84 e D50
		case 3 : [self utmtolatlon50 :   xcord :  ycord ];    break; // globo D50
		case 4 : [self utmtocatasto  :   xcord :  ycord ];	  break; // Cassini
        case 5 : [self utmtoGBoaga   :   xcord :  ycord ];    break;  // Gauss-Boaga
		default: break;
	}
}


- (void) utmtolatlon    : (double*) xcord : (double*) ycord         {
	double	a = 6378137.0;//equatorial radius, meters. 
	double f = 1.0/298.2572236;//polar flattening.
	double drad = M_PI/180.0;//Convert degrees to radians)
	double k0 = 0.9996;//scale on central meridian
	double b = a*(1-f);//polar axis.
	double e = sqrt(1 - (b/a)*(b/a));//eccentricity
									 //	double e0 = e/sqrt(1 - e*e);//Called e prime in reference
	double esq = (1.0 - (b/a)*(b/a));//e squared for use in expansions
	double e0sq = e*e/(1.0-e*e);// e0 squared - always even powers

	int utmz=33;

		//	double x = *xcord-2020000;
	double x = *xcord-(utmz-31)*1010000;

	
	double y = *ycord;
    double	zcm = 3.0 + 6.0*(utmz-1.0) - 180.0;//Central meridian of zone
	double e1 = (1.0 - sqrt(1.0 - e*e))/(1.0 + sqrt(1.0 - e*e));//Called e1 in USGS PP 1395 also
	double M0 = 0;//In case origin other than zero lat - not needed for standard UTM
	double M = M0 + y/k0;//Arc length along standard meridian. 
	double mu = M/(a*(1.0 - esq*(1.0/4.0 + esq*(3.0/64.0 + 5.0*esq/256.0))));
	double phi1 = mu + e1*(3.0/2.0 - 27.0*e1*e1/32.0)*sin(2*mu) + e1*e1*(21.0/16.0 -55.0*e1*e1/32.0)*sin(4*mu);//Footprint Latitude
	phi1 = phi1 + e1*e1*e1*(sin(6.0*mu)*151.0/96.0 + e1*sin(8.0*mu)*1097.0/512.0);
	double C1 = e0sq*pow(cos(phi1),2);
	double T1 = pow(tan(phi1),2);
	double N1 = a/sqrt(1-pow(e*sin(phi1),2));
	double R1 = N1*(1-e*e)/(1-pow(e*sin(phi1),2));
	double D = (x-500000)/(N1*k0);
	double phi = (D*D)*(1.0/2.0 - D*D*(5.0 + 3.0*T1 + 10.0*C1 - 4.0*C1*C1 - 9.0*e0sq)/24.0);
	phi = phi + pow(D,6)*(61.0 + 90.0*T1 + 298.0*C1 + 45.0*T1*T1 -252.0*e0sq - 3.0*C1*C1)/720.0;
	phi = phi1 - (N1*tan(phi1)/R1)*phi;
	
		//Longitude
	double lng = D*(1.0 + D*D*((-1.0 -2.0*T1 -C1)/6.0 + D*D*(5.0 - 2.0*C1 + 28.0*T1 - 3.0*C1*C1 +8.0*e0sq + 24.0*T1*T1)/120.0))/cos(phi1);
	double lngd = zcm+lng/drad;

	*xcord = lngd;
	*ycord = phi/drad;
}

- (void) utmtolatlon50 : (double*) xcord : (double*) ycord    {
   [self utmtolatlon   :   xcord :  ycord ]; 
    *xcord = *xcord+ 3.3/3600.0; *ycord = *ycord+ 3.6/3600.0; 
}


- (void) utmtoGBoaga    : (double*) xcord : (double*) ycord  {
       *xcord = *xcord+12;    *ycord = *ycord+10;	  
}


- (void) utmtoutm50    : (double*) xcord : (double*) ycord  {
	*xcord = *xcord+69;    *ycord = *ycord+192;	  
}


- (void) latlonToUtm    : (double*) xcord : (double*) ycord  {
		//Convert Latitude and Longitude to UTM
	double	a = 6378137.0;//equatorial radius, meters. 
	double f = 1.0/298.2572236;//polar flattening.
	double drad = M_PI/180.0;//Convert degrees to radians)
	double k0 = 0.9996;//scale on central meridian
	double b = a*(1-f);//polar axis.
	double e = sqrt(1 - (b/a)*(b/a));//eccentricity
    double latd = *ycord;   
	double lngd = *xcord;
	double phi = latd*drad;//Convert latitude to radians
	double utmz = 1.0 + floor((lngd+180.0)/6.0);//calculate utm zone
				utmz=33;
	double zcm = 3.0 + 6.0*(utmz-1) - 180.0;//Central meridian of zone
	double esq = (1.0 - (b/a)*(b/a));//e squared for use in expansions
	double e0sq = e*e/(1.0-e*e);// e0 squared - always even powers
	double N = a/sqrt(1.0-pow(e*sin(phi),2));
	double T = pow(tan(phi),2);
	double C = e0sq*pow(cos(phi),2);
	double A = (lngd-zcm)*drad*cos(phi);
	double M = phi*(1.0 - esq*((1.0/4.0) + esq*((3.0/64.0) + ((5.0*esq)/256.0))));
	M = M - sin(2*phi)*(esq*(3.0/8.0 + esq*(3.0/32.0 + 45.0*esq/1024.0)));
	M = M + sin(4*phi)*(esq*esq*(15.0/256.0 + esq*45.0/1024.0));
	M = M - sin(6*phi)*(esq*esq*esq*(35.0/3072.0));
	M = M*a;//Arc length along standard meridian
	double M0 = 0;//M0 is M for some origin latitude other than zero. Not needed for standard UTM
	double x = k0*N*A*(1 + A*A*((1.0-T+C)/6.0 + A*A*(5.0 - 18.0*T + T*T + 72.0*C -58.0*e0sq)/120.0));//Easting relative to CM
		   x = x+500000;//Easting standard 
	double y = k0*(M - M0 + N*tan(phi)*(A*A*(1.0/2.0 + A*A*((5.0 - T + 9.0*C + 4.0*C*C)/24.0 + A*A*(61.0 - 58.0*T + T*T + 600.0*C - 330.0*e0sq)/720.0))));//Northing from equator
	

	
			*xcord = x+(utmz-31)*1010000.0;
		//	*xcord = x+1*1010000;

	*ycord = y;
}

- (void) latlon50ToUtm    : (double*) xcord : (double*) ycord  {
			*xcord = *xcord - 3.3/3600.0;	        
			*ycord = *ycord - 3.6/3600.0;
	[self latlonToUtm    : xcord : ycord ];

}


- (void) GBoagaToUtm   : (double*) xcord : (double*) ycord  {
	*xcord = *xcord-12;    *ycord = *ycord-10;	  
}

- (void) utm50toutm    : (double*) xcord : (double*) ycord  {
	*xcord = *xcord-69;    *ycord = *ycord-192;	  
}



- (NSString *) ingradi : (double) valore {
	BOOL negativo =NO;
	double locvalore = valore;
	
	if (locvalore<0) {	locvalore=-locvalore; negativo=YES;	}
	int    Gradi;   int Minuti;
	Gradi  = (int)(locvalore);			locvalore = (locvalore - Gradi)*60.0;		
	
	if (locvalore>=60) { Gradi  = Gradi+1;  locvalore = locvalore-60.0;}
	Minuti = (int)(locvalore);		    locvalore = (locvalore -Minuti)*60.0;	
	if (locvalore>=59.99) { Minuti = Minuti+1; locvalore =0.0;	}
	if (negativo) return [NSString  stringWithFormat:	 @"-%d° %d' %5.2f\"",Gradi,Minuti,locvalore];	
	return [NSString  stringWithFormat:	 @"%d° %d' %5.2f\"",Gradi,Minuti,locvalore];	
}

- (int)      GradidaCord   : (double) valore {
		return (int)(valore);			
}

- (int)      MinutidaCord  : (double) valore {
	int    Gradi;   
	Gradi  = (int)(valore);			valore = (valore -Gradi)*60;		
	return (int)(valore);	
}

- (double)   SecondidaCord  : (double) valore {
	int    Gradi;   int Minuti;
	Gradi  = (int)(valore);			valore = (valore -Gradi)*60;		
	Minuti = (int)(valore);		valore = (valore -Minuti)*60;	
	return valore;
}

- (NSString *) SecondiStrdaCord : (double) valore {
	return [NSString  stringWithFormat:	 @"%1.1f",[self SecondidaCord:valore]];
}


- (NSString *) invirgcoord  : (double) valore {
	
	double valore2 = valore*100.0;
	
	NSMutableString  * risulta = [[NSMutableString alloc] initWithFormat: @"%1.0f",valore2 ];
	
	int lunga = [risulta length];
	
    [risulta insertString:@"," atIndex:lunga-2];
	if (lunga>5) {	[risulta insertString:@"." atIndex:lunga-5]; }
	if (lunga>8) {	[risulta insertString:@"." atIndex:lunga-8]; }
	
	return risulta;	
}



- (double)  offxroma { return offxroma;}

- (double)  offyroma { return offyroma;}


	//   qui le procedure di disegno pattern campiture.

#define PSIZE 12   // size of the pattern cell
void CampStella (void *info, CGContextRef myContext)
{
	CGContextSetLineWidth  (myContext,1.0);

    int k;    double r, theta;
    r = 0.8 * PSIZE / 2;
    theta = 2 * M_PI * (2.0 / 5.0); // 144 degrees
    CGContextTranslateCTM (myContext, PSIZE/2.0, PSIZE/2.0);
    CGContextMoveToPoint(myContext, 0, r);
    for (k = 1; k < 5; k++) {  CGContextAddLineToPoint (myContext, r * sin(k * theta), r * cos(k * theta));  }
    CGContextClosePath(myContext);
    CGContextStrokePath(myContext);
}

void CampStellaPiena (void *info, CGContextRef myContext)
{
    int k;    double r, theta;
    r = 0.8 * PSIZE / 2;
    theta = 2 * M_PI * (2.0 / 5.0); // 144 degrees
    CGContextTranslateCTM (myContext, PSIZE/2.0, PSIZE/2.0);
    CGContextMoveToPoint(myContext, 0, r);
    for (k = 1; k < 5; k++) {  CGContextAddLineToPoint (myContext, r * sin(k * theta), r * cos(k * theta));  }
    CGContextClosePath(myContext);
    CGContextFillPath(myContext);
}


void CampCerchio (void *info, CGContextRef hdc)
{
	CGContextTranslateCTM (hdc, PSIZE/2.0, PSIZE/2.0);
	CGContextAddArc (hdc, 0, 0 , PSIZE/4, 0, 2*M_PI, 0);
	CGContextStrokePath(hdc);
}

void CampCerchioPieno (void *info, CGContextRef hdc)
{
	CGContextTranslateCTM (hdc, PSIZE/2.0, PSIZE/2.0);
	CGContextAddArc (hdc, 0, 0 , PSIZE/4, 0, 2*M_PI, 0);
	CGContextFillPath(hdc);
}

void CampOrizzontali (void *info, CGContextRef hdc)
{
    CGContextTranslateCTM (hdc, 0  ,0);
    CGContextMoveToPoint(hdc, 0, 0);
	CGContextAddLineToPoint(hdc, PSIZE,0);
	CGContextStrokePath(hdc);
}

void CampVerticali (void *info, CGContextRef hdc)
{
	CGContextTranslateCTM (hdc, 0, 0);
    CGContextMoveToPoint(hdc, 0, 0);
	CGContextAddLineToPoint(hdc, 0,PSIZE);
	CGContextStrokePath(hdc);
}

void CampDiag1 (void *info, CGContextRef hdc)
{
	CGContextTranslateCTM (hdc, 0, 0);
    CGContextMoveToPoint(hdc, 0, 0);
	CGContextAddLineToPoint(hdc, PSIZE,PSIZE);
	CGContextStrokePath(hdc);
}

void CampDiag2 (void *info, CGContextRef hdc)
{
	CGContextTranslateCTM (hdc, 0, 0);
    CGContextMoveToPoint(hdc, PSIZE, 0);
	CGContextAddLineToPoint(hdc, 0,PSIZE);
	CGContextStrokePath(hdc);
}

void CampDiagdoppia (void *info, CGContextRef hdc)
{
	CGContextTranslateCTM (hdc, 0, 0);
    CGContextMoveToPoint(hdc, PSIZE, 0);
	CGContextAddLineToPoint(hdc, 0,PSIZE);
	CGContextStrokePath(hdc);
    CGContextMoveToPoint(hdc, 0, 0);
	CGContextAddLineToPoint(hdc, PSIZE,PSIZE);
	CGContextStrokePath(hdc);
}




- (void) settapattern :(CGContextRef) hdc : (int) indiceCamp : (float) rcol :  (float) gcol : (float) bcol : (float) alpa {
	CGPatternRef pattern;	
	CGColorSpaceRef baseSpace;	
	CGColorSpaceRef patternSpace;
    CGFloat colore[4] = { rcol, gcol, bcol, alpa };
	CGPatternCallbacks callbacks;
	callbacks.version     = 0;
	callbacks.releaseInfo = NULL;

    switch (indiceCamp) {
	   case 1:	callbacks.drawPattern = &CampCerchio;	    break;
	   case 2:	callbacks.drawPattern = &CampCerchioPieno;	break;
	   case 3:	callbacks.drawPattern = &CampStella;    	break;
	   case 4:	callbacks.drawPattern = &CampStellaPiena;	break;
		case 5:	callbacks.drawPattern = &CampOrizzontali;	break;
		case 6:	callbacks.drawPattern = &CampVerticali;     break;
		case 7:	callbacks.drawPattern = &CampDiag1;         break;
		case 8:	callbacks.drawPattern = &CampDiag2;         break;
		case 9:	callbacks.drawPattern = &CampDiagdoppia;    break;

				//	   case 2:	callbacks.drawPattern = &drawStar;	break;
	   default: return;	break;
    }	
	
	baseSpace = CGColorSpaceCreateDeviceRGB ();
	patternSpace = CGColorSpaceCreatePattern (baseSpace);
	CGContextSetFillColorSpace (hdc, patternSpace);
	CGColorSpaceRelease(patternSpace);									
	CGColorSpaceRelease(baseSpace);
	pattern = CGPatternCreate(NULL, CGRectMake(0, 0, PSIZE, PSIZE),
							  CGAffineTransformIdentity, PSIZE, PSIZE,
							  kCGPatternTilingConstantSpacing,
							  false, &callbacks);
	CGContextSetFillPattern (hdc, pattern, colore);
    CGPatternRelease (pattern);
}

@end
