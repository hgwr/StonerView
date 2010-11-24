/* StonerView: An eccentric visual toy.
   Copyright 1998-2001 by Andrew Plotkin (erkyrath@eblong.com)
   http://www.eblong.com/zarf/stonerview.html
   This program is distributed under the GPL.
   See main.c, the Copying document, or the above URL for details.
*/

/*
 * modified by hgwr@moreslowly.jp for porting to iOS. 
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include <OpenGLES/ES1/gl.h>
#include <OpenGLES/ES1/glext.h>

#include "general.h"
#include "osc.h"
#include "view.h"

#include "move.h"

static GLfloat view_rotx = -45.0, view_roty = 0.0, view_rotz = 0.0;
static GLfloat view_scale = 4.0;


void setup_window()
{
  glEnable(GL_CULL_FACE);
  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_NORMALIZE);
  glShadeModel(GL_FLAT);
}

/* callback: draw everything */
void win_draw(void)
{
  static int ix;
  static GLfloat vertices[12];

  glPushMatrix();
  glScalef(view_scale, view_scale, view_scale);
  glRotatef(view_rotx, 1.0, 0.0, 0.0);
  glRotatef(view_roty, 0.0, 1.0, 0.0);
  glRotatef(view_rotz, 0.0, 0.0, 1.0);

  for (ix=0; ix<NUM_ELS; ix++) {
    elem_t *el = &elist[ix];

    vertices[0] = el->pos[0] - el->vervec[0];
    vertices[1] = el->pos[1] - el->vervec[1];
    vertices[2] = el->pos[2];
    vertices[3] = el->pos[0] + el->vervec[1];
    vertices[4] = el->pos[1] - el->vervec[0];
    vertices[5] = el->pos[2];
    vertices[6] = el->pos[0] - el->vervec[1];
    vertices[7] = el->pos[1] + el->vervec[0];
    vertices[8] = el->pos[2];
    vertices[9] = el->pos[0] + el->vervec[0];
    vertices[10] = el->pos[1] + el->vervec[1];
    vertices[11] = el->pos[2];

    glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, el->col);
    glVertexPointer(3, GL_FLOAT, 0, vertices);
    glEnableClientState(GL_VERTEX_ARRAY);
    glNormal3f(0.0, 0.0, 1.0);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
  }

  glPopMatrix();
}

/* callback: new window size or exposure */
void win_reshape(int width, int height)
{
  GLfloat h = (GLfloat) height / (GLfloat) width;

  glViewport(0, 0, (GLint) width, (GLint) height);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  glFrustumf(-1.0, 1.0, -h, h, 5.0, 60.0);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
  glTranslatef(0.0, 0.0, -40.0);
}
