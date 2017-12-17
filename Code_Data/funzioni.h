/*
 *  funzioni.h
 *  GIS2010
 *
 *  Created by Carlo Macor on 25/07/10.
 *  Copyright 2010 Carlo Macor. All rights reserved.
 *
 */




void   rotocentra       ( double xc  , double yc  , double rotatt   , double rotprec   ,  double* xcord , double* ycord   );

void   scalacentra      ( double xc  , double yc  , double scalaatt , int modo , double scalaxprec , double scalayprec ,  double* xcord , double* ycord   );

double angolo2vertici   ( double xc  , double yc  , double x2       , double y2 );

double scala2verticischermo  ( double xc  , double yc  , double x2  , double y2 , double dimscr);

double distsemplicefunz      ( double x1 ,double y1,double x2 ,double y2 ); 

double distasegfunz          ( double x1  , double y1  , double x2       , double y2 , double xp , double yp  ); 

double xgriglia         ( double x1  , double y1  , double x2   , double y2   ,   double yy    );

double ygriglia         ( double x1  , double y1  , double x2   , double y2   ,   double xx    );

int   intersezione     ( double x1  , double y1  , double x2   , double y2   ,  double x3  , double y3  , double x4   , double y4   ,  double* xcord , double* ycord   ) ;


	//void leggirigafile ( NSString*  fileContents , int filepos,   NSString* riga);


