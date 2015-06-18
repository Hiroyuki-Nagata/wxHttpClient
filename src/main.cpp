/*
 * Main.cpp
 *
 *  Created on: 2011/06/26
 *      Author: Nantonaku-Shiawase
 */

#include "main.hpp"
#include "wxhttpclientframe.hpp"

IMPLEMENT_APP(MyApp)

bool MyApp::OnInit()
{
	WxHttpClientFrame *wxHttpClientFrame = new WxHttpClientFrame(wxT("WxHttpClientFrame"));
	wxHttpClientFrame->Show(true);

 return true;
}
