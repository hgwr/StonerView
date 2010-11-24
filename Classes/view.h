/* StonerView: An eccentric visual toy.
   Copyright 1998-2001 by Andrew Plotkin (erkyrath@eblong.com)
   http://www.eblong.com/zarf/stonerview.html
   This program is distributed under the GPL.
   See main.c, the Copying document, or the above URL for details.
*/

/*
 * modified by hgwr@moreslowly.jp for porting to iOS. 
 */

#ifndef __VIEW_H__
#define __VIEW_H__

#ifdef __cplusplus
extern "C" {
#endif

extern void setup_window(void);
extern void win_reshape(int width, int height);
extern void win_draw(void);

#ifdef __cplusplus
}
#endif

#endif
