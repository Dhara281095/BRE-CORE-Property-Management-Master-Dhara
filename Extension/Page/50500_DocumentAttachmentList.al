namespace PropertyManagement.PropertyManagement;

using Microsoft.Foundation.Attachment;

pageextension 50500 MyDocumentAttachmentFactbox extends "Doc. Attachment List Factbox"
{
    layout
    {
        addafter("File Extension")
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = All;
            }
            // field("Field Name"; Rec."Field Name")
            // {
            //     ApplicationArea = All;
            // }

            field("Table Name"; Rec."Table Name")
            {
                ApplicationArea = All;
            }

            field(DocumentMedia; Rec.DocumentMedia)
            {
                ApplicationArea = All;
                Caption = 'Document Preview';
                Editable = false;
                ToolTip = 'Displays the uploded document.';
            }


        }
    }
}