/*
 * Main.cpp
 *
 *  Created on: 2011/06/26
 *      Author: Nantonaku-Shiawase
 */

#include "Main.h"
#include "WxHttpClientFrame.h"

IMPLEMENT_APP(MyApp)

bool MyApp::OnInit()
{
	WxHttpClientFrame *wxHttpClientFrame = new WxHttpClientFrame(wxT("WxHttpClientFrame"));
	wxHttpClientFrame->Show(true);

 return true;
}
