/*
 * WxHttpClientFrame.h
 *
 *  Created on: 2011/06/26
 *      Author: Nantonaku-Shiawase
 */

#ifndef WXHTTPCLIENTFRAME_H
#define WXHTTPCLIENTFRAME_H

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

	void OnButtonQuit(wxCommandEvent& event);

	void OnButtonGetHttp(wxCommandEvent& event);

protected:
	//URL入力用文字列
	wxTextCtrl *m_tc;

	//HTTP文出力用文字列
	wxTextCtrl *m_tc2;

private:
    DECLARE_EVENT_TABLE()
};

#endif // WXHTTPCLIENTFRAME_H
