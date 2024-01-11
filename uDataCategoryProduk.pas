unit uDataCategoryProduk;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, odbcconn, DB, Forms, Controls, Graphics, Dialogs,
  DBGrids, StdCtrls, uTambahKategori, uUpdateKategori;

type

  { TTfrmDataCategoryProduk }

  TTfrmDataCategoryProduk = class(TForm)
    BtnAddKategori: TButton;
    BtnReset: TButton;
    BtnDelete: TButton;
    BtnCari: TButton;
    BtnUpdate: TButton;
    DataSourceKatagori: TDataSource;
    DBGridKategori: TDBGrid;
    ECari: TEdit;
    Label1: TLabel;
    SQLConnector1: TSQLConnector;
    SQLQueryKategori: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure BtnAddKategoriClick(Sender: TObject);
    procedure BtnCariClick(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure BtnResetClick(Sender: TObject);
    procedure BtnUpdateClick(Sender: TObject);
    procedure DBGridKategoriCellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    procedure AmbilKategori;

  public

  end;

var
  TfrmDataCategoryProduk: TTfrmDataCategoryProduk;
  idGrid: integer;

implementation

{$R *.lfm}

{ TTfrmDataCategoryProduk }

procedure TTfrmDataCategoryProduk.AmbilKategori;
begin
with SQLQueryKategori do
  begin
    Close;
    SQL.Text := 'SELECT * FROM kategori';
    Open;
  end;
end;

procedure TTfrmDataCategoryProduk.FormCreate(Sender: TObject);
begin
  AmbilKategori;
end;

procedure TTfrmDataCategoryProduk.BtnDeleteClick(Sender: TObject);
var
  Response: Integer;
begin
  if idGrid <> 0 then
  begin
    Response := MessageDlg('You sure want remove?', mtConfirmation, mbYesNo, 0);
    if Response = mrYes then
    begin
      try
          with SQLQueryKategori do
          begin
            Close;
            SQL.Text := 'DELETE FROM kategori WHERE id = :id ';
            Params.ParamByName('id').AsString := IntToStr(idGrid);
            ExecSQL;
            SQLTransaction1.Commit;
            AmbilKategori;
          end;
        except
           on E: Exception do
           begin
              ShowMessage('ERROR! : ' + E.Message);
              SQLTransaction1.Rollback;
           end;
        end;
    end;
  end
  else
    ShowMessage('Selection Empty');
end;

procedure TTfrmDataCategoryProduk.BtnResetClick(Sender: TObject);
begin
   AmbilKategori;
   ECari.Text:='';
end;

procedure TTfrmDataCategoryProduk.BtnUpdateClick(Sender: TObject);
var
  frmUpdateKategori: TTfrmUpdateKategori;
begin
  if idGrid <> 0 then
  begin
    try
      frmUpdateKategori := TTfrmUpdateKategori.Create(Self);
      Self.Hide;
      frmUpdateKategori.setId(idGrid);
      frmUpdateKategori.setNama;
      if frmUpdateKategori.ShowModal = mrOk then
      begin
         ModalResult := mrOk;
      end
      else
         Self.Show;
    finally
      frmUpdateKategori.Free;
    end;
  end
  else
    ShowMessage('Error');
end;

procedure TTfrmDataCategoryProduk.BtnCariClick(Sender: TObject);
begin
  with SQLQueryKategori do
  begin
    Close;
    SQL.Text := 'SELECT * FROM kategori WHERE nama LIKE :nama ';
    Params.ParamByName('nama').AsString := '%' + ECari.Text + '%';
    Open;
  end;
end;

procedure TTfrmDataCategoryProduk.BtnAddKategoriClick(Sender: TObject);
var
  frmTambahKategori: TTfrmTambahKategori;
begin
  try
    frmTambahKategori := TTfrmTambahKategori.Create(Self);
    Self.Hide;
    if frmTambahKategori.ShowModal = mrOk then
    begin
       ModalResult := mrOk;
    end
    else
       Self.Show;
  finally
    frmTambahKategori.Free;
  end;
end;

procedure TTfrmDataCategoryProduk.DBGridKategoriCellClick(Column: TColumn);
begin
   idGrid := StrToInt(DBGridKategori.DataSource.DataSet.FieldByName('id').AsString);
end;

procedure TTfrmDataCategoryProduk.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
   ModalResult := mrOk;
end;

end.

