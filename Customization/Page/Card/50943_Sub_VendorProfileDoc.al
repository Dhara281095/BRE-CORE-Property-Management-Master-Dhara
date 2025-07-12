page 50943 "Vendor I/R DocumentSub"
{
    PageType = ListPart;
    SourceTable = "Vendor Contract Document";
    ApplicationArea = All;
    Caption = 'Vendor Invoice/Receipt Documents';

    layout
    {
        area(content)
        {
            repeater("Documents")
            {

                field("Vendor ID"; Rec."Vendor ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Amount"; Rec."Amount")
                {
                    ApplicationArea = All;
                }

                field("Payment Status"; Rec."Payment Status")
                {
                    ApplicationArea = All;
                }

                field("Invoice ID"; Rec."Invoice ID")
                {
                    ApplicationArea = All;
                }

                field("Invoice Document Upload"; Rec."Invoice Document Upload")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        azureBlobUploader: Codeunit "Azure AD Blob Storage";
                        fileName: Text;
                        uploadResult: Text;
                        folderName: Text;
                    begin

                        folderName := 'PropertyDocuments';
                        fileName := azureBlobUploader.ValidateDocument(uploadResult, folderName);
                        if fileName <> '' then begin
                            Rec."Invoice Document Upload" := fileName;
                            Rec."Invoice Document URL" := uploadResult;
                            Rec.Modify();
                            Message('File uploaded successfully: %1', fileName);
                        end;
                    end;
                }

                field("Invoice Document View"; Rec."Invoice Document View")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        FileURL: Text;
                    begin
                        // Get the URL of the uploaded document
                        FileURL := Rec."Invoice Document URL";

                        // Check if the file URL is not empty
                        if FileURL = '' then
                            Error('No document is available to view.');

                        // Open the file URL in the browser (new tab)
                        OpenFileInBrowser(FileURL);

                    end;
                }

                field("Invoice Document URL"; Rec."Invoice Document URL")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }

                field("Receipt ID"; Rec."Receipt ID")
                {
                    ApplicationArea = All;
                }

                field("Receipt Document Upload"; Rec."Receipt Document Upload")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        azureBlobUploader: Codeunit "Azure AD Blob Storage";
                        fileName: Text;
                        uploadResult: Text;
                        folderName: Text;
                    begin
                        folderName := 'PropertyDocuments';
                        fileName := azureBlobUploader.ValidateDocument(uploadResult, folderName);
                        if fileName <> '' then begin
                            Rec."Receipt Document Upload" := fileName;
                            Rec."Receipt Document URL" := uploadResult;
                            Rec.Modify();
                            Message('File uploaded successfully: %1', fileName);
                        end;
                    end;
                }

                field("Receipt Document View"; Rec."Receipt Document View")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        FileURL: Text;
                    begin
                        // Get the URL of the uploaded document
                        FileURL := Rec."Receipt Document URL";

                        // Check if the file URL is not empty
                        if FileURL = '' then
                            Error('No document is available to view.');

                        // Open the file URL in the browser (new tab)
                        OpenFileInBrowser(FileURL);

                    end;
                }

                field("Receipt Document URL"; Rec."Receipt Document URL")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    procedure OpenFileInBrowser(URL: Text)
    begin
        // Use the Hyperlink method to open the file in the browser
        if URL <> '' then
            Hyperlink(URL)
        else
            Error('The file URL is invalid.');
    end;


    procedure SetVendorID(pVendorID: Code[20])
    begin
        VendorID := pVendorID;
    end;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        vendor: Record "Vendor Profile";
        PaymentStatus: Enum "Payment Status";
    begin
        Rec."Vendor ID" := VendorID;

        vendor.SetRange("vendor ID", Rec."vendor ID");
        if vendor.FindSet() then begin
            if Rec."Payment Status" = PaymentStatus::" " then
                Rec."Payment Status" := PaymentStatus::Scheduled;
        end;
    end;

    var
        VendorID: Code[20];

    trigger OnModifyRecord(): Boolean
    var
        vendor: Record "Vendor Profile";
        PaymentStatus: Enum "Payment Status";
    begin
        vendor.SetRange("vendor ID", Rec."vendor ID");
        if vendor.FindSet() then begin
            if Rec."Payment Status" = PaymentStatus::" " then
                Rec."Payment Status" := PaymentStatus::Scheduled;
        end;
    end;

}
