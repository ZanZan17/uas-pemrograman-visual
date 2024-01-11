unit uTambahProduk;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, odbcconn, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBCtrls;

type

  { TTfrmTambahProduk }

  TTfrmTambahProduk = class(TForm)
    BSimpan: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBLookupkategori: TDBLookupComboBox;
    EJumlahStok: TEdit;
    EHargaJual: TEdit;
    EHargaBeli: TEdit;
    ENama: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SQLConnector1: TSQLConnector;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure BSimpanClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public
     add: boolean

  end;

var
  TfrmTambahProduk: TTfrmTambahProduk;

implementation

{$R *.lfm}

{ TTfrmTambahProduk }
procedure TTfrmTambahProduk.BSimpanClick(Sender: TObject);
begin
  try
    with SQLQuery2 do
    begin
      SQL.Clear;
      SQL.Add('INSERT INTO data_barang (nama, kategori_id, harga_beli, harga_jual, stok)');
      SQL.Add('VALUES (:nama, :kategori_id, :harga_beli, :harga_jual, :stok)');
      Params.ParamByName('nama').AsString:=ENama.Text;
      Params.ParamByName('kategori_id').AsInteger:=DBLookupkategori.KeyValue;
      Params.ParamByName('harga_beli').AsInteger:=StrToInt(EHargaBeli.Text);
      Params.ParamByName('harga_jual').AsInteger:=StrToInt(EHargaJual.Text);
      Params.ParamByName('stok').AsInteger:=StrToInt(EJumlahStok.Text);
      ExecSQL;
      SQLTransaction1.Commit;

      ENama.Text:='';
      EHargaBeli.Text:='';
      EHargaJual.Text:='';
      EJumlahStok.Text:='';
      add := True;
      ShowMessage('Success');
    end;
    SQLQuery1.Open;
  except
    on E: Exception do
       ShowMessage('ERROR! : ' + E.message);
  end;
end;

procedure TTfrmTambahProduk.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  if add = True then
  begin
      add := False;
      ModalResult:= mrOk;
  end
  else
      ModalResult:= mrCancel;
end;

procedure TTfrmTambahProduk.FormCreate(Sender: TObject);
begin
  SQLQuery1.Open;
end;

end.

