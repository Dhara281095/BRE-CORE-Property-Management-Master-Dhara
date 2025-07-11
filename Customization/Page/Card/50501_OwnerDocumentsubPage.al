page 50501 "Owner Document Subpage"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = DocumentUploadDetails;
    Caption = 'Owner Document Attachments';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }

                field("Document Name"; Rec."Document Name")
                {
                    ApplicationArea = All;
                }

                field("Upload Document"; Rec."Upload Document")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        azureBlobUploader: Codeunit "Azure AD Blob Storage";
                        fileName: Text;
                        uploadResult: Text;
                        folderName: Text;
                    begin
                        folderName := 'TenancyContractDocuments';
                        fileName := azureBlobUploader.ValidateDocument(uploadResult, folderName);
                        if fileName <> '' then begin
                            Rec."Upload Document" := fileName;
                            Rec."View Document URL" := uploadResult;
                            Rec.Modify();
                            Message('File uploaded successfully: %1', fileName);
                        end;
                    end;
                }

                field("View & Download"; Rec."View & Download")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        FileURL: Text;
                    begin
                        // Get the URL of the uploaded document
                        FileURL := Rec."View Document URL";

                        // Check if the file URL is not empty
                        if FileURL = '' then
                            Error('No document is available to view.');

                        // Open the file URL in the browser (new tab)
                        OpenFileInBrowser(FileURL);
                    end;
                }
                field(Download; Rec.Download)
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;
                    Visible = false;

                    trigger OnDrillDown()
                    var
                        AttachmentRec: Record "Document Attachment";
                        InStreamVar: InStream;
                        FileName: Text;
                        ToFile: Text;
                    begin
                        // Find the attachment record
                        AttachmentRec.SetRange("No.", Format(Rec.OwnerId));
                        AttachmentRec.SetRange("Table ID", 50500); // Adjust to match your table ID
                        AttachmentRec.SetRange("File Name", Rec."Upload Document");

                        if AttachmentRec.FindSet() then begin
                            FileName := AttachmentRec."File Name";
                            ToFile := FileName;

                            if AttachmentRec.HasContent() then begin
                                AttachmentRec.Export(true);
                            end;

                        end
                        else begin
                            Message('Document not found.');
                        end;


                    end;
                }

            }
        }
    }

    procedure SetOwnerId(pOwnerId: Integer)
    begin
        OwnerId := pOwnerId;
    end;

    // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // begin
    //     Rec.OwnerId := OwnerId;
    // end;

    // procedure SetHeaderNo(HeaderNo: Integer)
    // begin
    //     OwnerId := HeaderNo;
    // end;
    procedure OpenFileInBrowser(URL: Text)
    begin
        // Use the Hyperlink method to open the file in the browser
        if URL <> '' then
            Hyperlink(URL)
        else
            Error('The file URL is invalid.');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.OwnerId := OwnerId;
    end;
    // trigger OnOpenPage();
    // var
    //     DocAttachmentRec: Record "Document Attachment";
    // begin
    //     // Check and insert predefined document types
    //     if not DocAttachmentRec.Get(DocAttachmentRec."ID") then begin
    //         // InsertPredefinedDocumentTypes(DocAttachmentRec);
    //     end;
    // end;

    // local procedure InsertPredefinedDocumentTypes(var DocAttachmentRec: Record "Document Attachment")
    // begin
    //     if not DocAttachmentRec.Get(Rec."Upload Document Type"::"Passport Number") then begin
    //         DocAttachmentRec.Init();
    //         DocAttachmentRec."Upload Document Type" := "Document Type Enum"::"Passport Number";
    //         DocAttachmentRec.Insert();
    //     end;

    //     if not DocAttachmentRec.Get(Rec."Upload Document Type"::Visa) then begin
    //         DocAttachmentRec.Init();
    //         DocAttachmentRec."Upload Document Type" := "Document Type Enum"::Visa;
    //         DocAttachmentRec.Insert();
    //     end;

    //     if not DocAttachmentRec.Get(Rec."Upload Document Type"::"Emirates ID") then begin
    //         DocAttachmentRec.Init();
    //         DocAttachmentRec."Upload Document Type" := "Document Type Enum"::"Emirates ID";
    //         DocAttachmentRec.Insert();
    //     end;

    //     if not DocAttachmentRec.Get(Rec."Upload Document Type"::"Other Documents") then begin
    //         DocAttachmentRec.Init();
    //         DocAttachmentRec."Upload Document Type" := "Document Type Enum"::"Other Documents";
    //         DocAttachmentRec.Insert();
    //     end;
    // end;

    // procedure InsertPredefinedDocumentTypes(tableId: Integer; ownerProfile: Record "Owner Profile")
    // var
    //     DocAttachmentRec: Record "Document Attachment";
    //     lineNo: Integer;
    // begin
    //     lineNo := 10000;
    //     // Insert Passport Number Document if it doesn't exist
    //     DocAttachmentRec.Reset();
    //     DocAttachmentRec.SetRange("Table ID", tableId);
    //     DocAttachmentRec.SetRange("No.", Format(ownerProfile."Owner ID"));
    //     DocAttachmentRec.SetRange("Upload Document Type", "Document Type Enum"::"Passport Number");
    //     if not DocAttachmentRec.FindSet() then begin
    //         DocAttachmentRec.Init();
    //         DocAttachmentRec."Table ID" := tableId;
    //         DocAttachmentRec."No." := Format(ownerProfile."Owner ID");
    //         DocAttachmentRec."Upload Document Type" := "Document Type Enum"::"Passport Number";
    //         DocAttachmentRec."Line No." := lineNo;
    //         DocAttachmentRec.Insert();
    //         lineNo += 10000;
    //     end;

    //     // Insert Visa Document if it doesn't exist
    //     DocAttachmentRec.Reset();
    //     DocAttachmentRec.SetRange("Table ID", tableId);
    //     DocAttachmentRec.SetRange("No.", Format(ownerProfile."Owner ID"));
    //     DocAttachmentRec.SetRange("Upload Document Type", "Document Type Enum"::Visa);
    //     if not DocAttachmentRec.FindSet() then begin
    //         DocAttachmentRec.Init();
    //         DocAttachmentRec."Table ID" := tableId;
    //         DocAttachmentRec."No." := Format(ownerProfile."Owner ID");
    //         DocAttachmentRec."Upload Document Type" := "Document Type Enum"::Visa;
    //         DocAttachmentRec."Line No." := lineNo;
    //         DocAttachmentRec.Insert();
    //         lineNo += 10000;
    //     end;

    //     // Insert Emirates ID Document if it doesn't exist
    //     DocAttachmentRec.Reset();
    //     DocAttachmentRec.SetRange("Table ID", tableId);
    //     DocAttachmentRec.SetRange("No.", Format(ownerProfile."Owner ID"));
    //     DocAttachmentRec.SetRange("Upload Document Type", "Document Type Enum"::"Emirates ID");
    //     if not DocAttachmentRec.FindSet() then begin
    //         DocAttachmentRec.Init();
    //         DocAttachmentRec."Table ID" := tableId;
    //         DocAttachmentRec."No." := Format(ownerProfile."Owner ID");
    //         DocAttachmentRec."Upload Document Type" := "Document Type Enum"::"Emirates ID";
    //         DocAttachmentRec."Line No." := lineNo;
    //         DocAttachmentRec.Insert();
    //         lineNo += 10000;
    //     end;

    //     // Insert Other Documents if it doesn't exist
    //     DocAttachmentRec.Reset();
    //     DocAttachmentRec.SetRange("Table ID", tableId);
    //     DocAttachmentRec.SetRange("No.", Format(ownerProfile."Owner ID"));
    //     DocAttachmentRec.SetRange("Upload Document Type", "Document Type Enum"::"Other Documents");
    //     if not DocAttachmentRec.FindSet() then begin
    //         DocAttachmentRec.Init();
    //         DocAttachmentRec."Table ID" := tableId;
    //         DocAttachmentRec."No." := Format(ownerProfile."Owner ID");
    //         DocAttachmentRec."Upload Document Type" := "Document Type Enum"::"Other Documents";
    //         DocAttachmentRec."Line No." := lineNo;
    //         DocAttachmentRec.Insert();
    //         lineNo += 10000;
    //     end;
    // end;



    var
        OwnerId: Integer;
        documentattachment: Codeunit UploadAttachment;
}