program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uMain, uTambahProduk, uUpdateProduk, uProduk, uPembayaran,
  uTambahPembayaran, uTambahDetailPembayaran, uLapor, uDataCategoryProduk,
uTambahCategory, uUpdateCategory, uSign;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TTfrmMain, TfrmMain);
  Application.CreateForm(TTfrmSign, TfrmSign);
  Application.CreateForm(TTfrmProduk, TfrmProduk);
  Application.CreateForm(TTfrmPembayaran, TfrmPembayaran);
  Application.CreateForm(TTfrmTambahProduk, TfrmTambahProduk);
  Application.CreateForm(TTfrmTambahDetailPembayaran, TfrmTambahDetailPembayaran
    );
  Application.CreateForm(TTfrmTambahCategory, TfrmTambahCategory);
  Application.CreateForm(TTfrmTambahPembayaran, TfrmTambahPembayaran);
  Application.CreateForm(TTfrmLapor, TfrmLapor);
  Application.CreateForm(TTfrmUpdateProduk, TfrmUpdateProduk);
  Application.CreateForm(TTfrmDataCategoryProduk, TfrmDataCategoryProduk);
  Application.CreateForm(TTfrmUpdateCategory, TfrmUpdateCategory);
  Application.Run;
end.

