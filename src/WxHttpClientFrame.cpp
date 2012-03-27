/*
 * WxHttpClientFrame.cpp
 *
 *  Created on: 2011/06/26
 *      Author: Nantonaku-Shiawase
 */

#include "WxHttpClientFrame.h"

/*
 * フレームクラス　GUIの描画・HTTP通信の処理を行う
 */
WxHttpClientFrame::WxHttpClientFrame(const wxString& title) : wxFrame(NULL, -1, title, wxPoint(-1, -1), wxSize(640, 480)) {

	// 一つのパネルには一つのサイザーが伴う
	wxPanel *panel = new wxPanel(this, -1);
	wxBoxSizer *vbox = new wxBoxSizer(wxVERTICAL);

	// hbox1 説明ラベルとURL入力欄
	wxBoxSizer *hbox1 = new wxBoxSizer(wxHORIZONTAL);
	wxStaticText *st1 = new wxStaticText(panel, wxID_ANY, wxT("ここにURLを入力"));

	hbox1->Add(st1, 0, wxRIGHT, 8);

	// ヘッダファイルでwxTextCtrlをクラス変数にしておけばこのメソッドの外からもインスタンスに触れる
	m_tc = new wxTextCtrl(panel, wxID_ANY);
	hbox1->Add(m_tc, 1);
	vbox->Add(hbox1, 0, wxEXPAND | wxLEFT | wxRIGHT | wxTOP, 10);

	vbox->Add(-1, 10);

	// hbox2 ラベル部分
	wxBoxSizer *hbox2 = new wxBoxSizer(wxHORIZONTAL);
	wxStaticText *st2 = new wxStaticText(panel, wxID_ANY, wxT("HTML Sources"));

	hbox2->Add(st2, 0);
	vbox->Add(hbox2, 0, wxLEFT | wxTOP, 10);

	vbox->Add(-1, 10);

	// hbox3 HTML文表示部分
	wxBoxSizer *hbox3 = new wxBoxSizer(wxHORIZONTAL);
	// インスタンスは外部からアクセスできる
	m_tc2 = new wxTextCtrl(panel, wxID_ANY, wxT(""), wxPoint(-1, -1), wxSize(-1, -1), wxTE_MULTILINE);

	hbox3->Add(m_tc2, 1, wxEXPAND);
	vbox->Add(hbox3, 1, wxLEFT | wxRIGHT | wxEXPAND, 10);

	vbox->Add(-1, 25);

	// hbox5　ボタン配置部分
	wxBoxSizer *hbox5 = new wxBoxSizer(wxHORIZONTAL);
	// ボタン１はOK　HTTPクライアントを起動させる
	wxButton *btn1 = new wxButton(panel, wxID_GETHTTP, wxT("Ok"));
	hbox5->Add(btn1, 0);
	// ボタン２はクローズ　アプリケーションを終了させる
	wxButton *btn2 = new wxButton(panel, wxID_EXIT, wxT("閉じる"));
	hbox5->Add(btn2, 0, wxLEFT | wxBOTTOM, 5);
	vbox->Add(hbox5, 0, wxALIGN_RIGHT | wxRIGHT, 10);

	panel->SetSizer(vbox);

	Centre();
}
/**
 * 閉じるボタンを押した時の処理を行うメソッド
 */
void WxHttpClientFrame::onButtonQuit(wxCommandEvent& WXUNUSED(event)) {
	Close(true);
}
/**
 * OKボタンを押した時HTTP通信を行うメソッド
 */
void WxHttpClientFrame::onButtonGetHttp(wxCommandEvent& WXUNUSED(event)) {

	// テキストコントロールからURLの文字列を取得する
	wxString inputURL = m_tc->GetValue();
	wxURL url(inputURL);

	// wxURLのGetInputStreamメソッドを使ってHTTP GET
	wxInputStream* readHtml = url.GetInputStream();
	// InputStreamをTextInputStreamに渡す(Javaでもよく使われるテクニック)
	wxTextInputStream in(*readHtml);
	wxString HTTPtext;

	// 読み出せるだけ読み出す
	while (readHtml->CanRead()) {
		HTTPtext += in.ReadLine(); // wxStringは左のような形で連結できる
	}

	// 作成したインスタンスはdeleteするのがC++の掟
	delete readHtml;

	// もう一つのテキストコントロールに取得したテキストをセットする
	m_tc2->SetValue(HTTPtext);
}

// イベントテーブル
BEGIN_EVENT_TABLE(WxHttpClientFrame, wxFrame)
// ボタン１はOK　HTTPクライアントを起動させる
EVT_BUTTON(wxID_EXIT, WxHttpClientFrame::onButtonQuit)
// ボタン２はクローズ　アプリケーションを終了させる
EVT_BUTTON(wxID_GETHTTP, WxHttpClientFrame::onButtonGetHttp)
END_EVENT_TABLE()
