/*
 * WxHttpClientFrame.h
 *
 *  Created on: 2011/06/26
 *      Author: Nantonaku-Shiawase
 */

#ifndef WXHTTPCLIENTFRAME_HPP
#define WXHTTPCLIENTFRAME_HPP

#include <wx/wx.h>
#include <wx/url.h>
#include <wx/stream.h>
#include <wx/txtstrm.h>

// control ids
enum
{
	wxID_GETHTTP
};

class WxHttpClientFrame : public wxFrame
{
public:
	WxHttpClientFrame(const wxString& title);

	void onButtonQuit(wxCommandEvent& event);

	void onButtonGetHttp(wxCommandEvent& event);

protected:
	//URL入力用文字列
	wxTextCtrl *m_tc;

	//HTTP文出力用文字列
	wxTextCtrl *m_tc2;

private:
    DECLARE_EVENT_TABLE()
};

#endif // WXHTTPCLIENTFRAME_HPP
