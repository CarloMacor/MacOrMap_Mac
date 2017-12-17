//
//  BarileCtr.h
//  MacOrMap
//
//  Created by Carlo Macor on 23/07/11.
//  Copyright 2011 Carlo Macor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CtrEdi.h"
#import "CtrEdiFiltro.h"
#import "CtrTer.h"
#import "CtrTerFiltro.h"
#import "CtrAnagrafe.h"
#import "CtrAnagFiltro.h"
#import "CtrDlgTax.h"
#import "CtrProprietari.h"
#import "CtrPropFiltro.h"
#import "CtrPossessori.h"
#import "CtrPatrimonio.h"
#import "CtrDlgVector.h"
#import "CtrDlgRaster.h"
#import "CtrDlgGriglia.h"


@interface BarileCtr : NSObject {
	IBOutlet CtrEdi              *  ctrEdi;
	IBOutlet CtrEdiFiltro        *  ctrEdiFiltro;
	IBOutlet CtrTer              *  ctrTer;
	IBOutlet CtrTerFiltro        *  ctrTerFiltro;
	IBOutlet CtrDlgTax           *  ctrTax;  // ici & Tarsu
	IBOutlet CtrAnagrafe         *  ctrAnagrafe;
	IBOutlet CtrAnagFiltro       *  ctrAnagFiltro;
	IBOutlet CtrProprietari      *  ctrProprietari;
	IBOutlet CtrPropFiltro       *  ctrPropFiltro;
	IBOutlet CtrPossessori       *  ctrPossessori;
	IBOutlet CtrPatrimonio       *  ctrPatrimonio;
	IBOutlet CtrDlgRaster        *  ctrDlgRaster;
	IBOutlet CtrDlgVector        *  ctrDlgVector;
	IBOutlet CtrDlgGriglia       *  ctrDlgGriglia;
}

- (CtrEdi             *)  ctrEdi;
- (CtrEdiFiltro       *)  ctrEdiFiltro;
- (CtrTer             *)  ctrTer;
- (CtrTerFiltro       *)  ctrTerFiltro;
- (CtrDlgTax          *)  ctrTax;
- (CtrAnagrafe        *)  ctrAnagrafe;
- (CtrAnagFiltro      *)  ctrAnagFiltro;
- (CtrProprietari     *)  ctrProprietari;
- (CtrPropFiltro      *)  ctrPropFiltro;
- (CtrPossessori      *)  ctrPossessori;
- (CtrPatrimonio      *)  ctrPatrimonio;
- (CtrDlgRaster       *)  ctrDlgRaster;
- (CtrDlgVector       *)  ctrDlgVector;
- (CtrDlgGriglia      *)  ctrDlgGriglia;


@end
