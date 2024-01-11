unit uTambahPembayaran;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, uTambahDetailTransaksi;

type

  { TTfrmTambahPembayaran }

  TTfrmTambahPembayaran = class(TForm)
    BTambahTransaksi: TButton;
    ECustomer: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure BTambahTransaksiClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  TfrmTambahPembayaran: TTfrmTambahPembayaran;

implementation

{$R *.lfm}

{ TTfrmTambahPembayaran }

procedure TTfrmTambahPembayaran.BTambahTransaksiClick(Sender: TObject);
var
  frmTambahDetailTransaksi: TTfrmTambahDetailTransaksi;
begin

    if Length(ECustomer.Text) > 3 then
    begin
      try
      frmTambahDetailTransaksi := TTfrmTambahDetailTransaksi.Create(Self);
      frmTambahDetailTransaksi.SetCustomer(ECustomer.Text);
      Self.Hide;
      if frmTambahDetailTransaksi.ShowModal = mrOk then
      begin
          ModalResult := mrOk;
      end
      else
          ModalResult := mrCancel;
      finally
          frmTambahDetailTransaksi.Free;
      end;
    end
    else
        ShowMessage('Nama customer tidak boleh kurang dari 3');
end;

procedure TTfrmTambahPembayaran.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin

end;

end.

