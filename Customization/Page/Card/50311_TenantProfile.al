// page 50311 "Tenant Profile Card"
// {
//     PageType = Card;
//     SourceTable = "TenantProfile";
//     ApplicationArea = All;
//     Caption = 'Tenant Profile Card';

//     // UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             group(Group)
//             {
//                 Caption = 'Tenant Identification Details';

//                 field("Tenant ID"; rec."Tenant ID")
//                 {
//                     ApplicationArea = All;

//                 }

//                 field("Full Name"; rec."Full Name")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field("Username"; rec."Username")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Username';
//                 }

//                 field("Password"; rec."Password")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Password';

//                 }
//                 field("Date Of Birth"; rec."Date Of Birth")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field("Nationality"; rec."Nationality")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field("Emirates ID"; rec."Emirates ID")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field("Emirates ID Expiry Date"; rec."Emirates ID Expiry Date")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field("License No."; Rec."License No.")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field("Licensing Authority"; Rec."Licensing Authority")
//                 {
//                     ApplicationArea = All;
//                 }



//                 field("Code Area"; Rec."Code Area")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Code Area';
//                 }
//                 field("Contact Number"; rec."Contact Number")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field("Email Address"; rec."Email Address")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field("Mailing Address"; rec."Mailing Address")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field("Local Address"; rec."Local Address")
//                 {
//                     ApplicationArea = All;
//                 }



//                 field("Emergency Contact"; rec."Emergency Contact")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field("Occupation"; rec."Occupation")
//                 {
//                     ApplicationArea = All;
//                 }

//                 // field("Recurring Sales Line Code"; Rec."Recurring Sales Line Code")
//                 // {
//                 //     ApplicationArea = All;
//                 //     ToolTip = 'Select the recurring sales line template to be link to this tenant.';
//                 // }



//                 // field("Property ID"; rec."Property ID")
//                 // {
//                 //     ApplicationArea = All;
//                 //     Lookup = true; // Enable lookup for Property ID
//                 // }

//                 // field("Unit ID"; rec."Unit ID")
//                 // {
//                 //     ApplicationArea = All;
//                 //     Lookup = true; // Enable lookup for Unit ID
//                 // }

//             }

//             group("Passport Details")
//             {
//                 field("Passport Number"; rec."Passport Number")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Passport Issue Date"; rec."Passport Issue Date")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Passport Expiry Date"; rec."Passport Expiry Date")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Country of Passport"; rec."Country of Passport")
//                 {
//                     ApplicationArea = All;
//                 }
//             }

//             part("Document Attachments"; "Tenant Document SubPage")
//             {
//                 SubPageLink = TenantID = FIELD("Tenant ID"); // Link to filter attachments for this owner only
//                 ApplicationArea = All;
//                 Visible = isVisible;
//             }

//             group("Tenant Screening")
//             {
//                 field("Approve"; Rec."Approve")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Approve';
//                 }
//                 field("Decline"; Rec."Decline")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Decline';
//                 }
//             }

//         }

//         area(factboxes)
//         {
//             // part("Attached Documents"; "Document Attachment Factbox")
//             // {
//             //     ApplicationArea = All;
//             //     Caption = 'Attachments';
//             //     SubPageLink = "Table ID" = const(Database::TenantProfile),
//             //                 //   "No." = field("No.");
//             //                 "No." = field("Tenant ID");

//             // }

//             // part("Attached Documents List"; "Doc. Attachment List Factbox")
//             // {
//             //     ApplicationArea = All;
//             //     Caption = 'Documents';
//             //     UpdatePropagation = Both;
//             //     SubPageLink = "Table ID" = const(Database::TenantProfile),
//             //           "No." = field("Tenant ID");
//             // }



//             part(ItemAttributesFactbox; "Item Attributes Factbox")
//             {
//                 ApplicationArea = Basic, Suite;
//             }


//             systempart(Control1900383207; Links)
//             {
//                 ApplicationArea = RecordLinks;
//             }

//             systempart(Control1905767507; Notes)
//             {
//                 ApplicationArea = Notes;
//             }
//         }
//     }

//     var
//         isVisible: Boolean;

//     trigger OnModifyRecord(): Boolean
//     begin
//         CurrPage."Document Attachments".Page.SetPropertyId(Rec."Tenant ID");
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         CurrPage."Document Attachments".Page.SetPropertyId(Rec."Tenant ID");
//         isVisible := true;
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         CurrPage."Document Attachments".Page.SetPropertyId(Rec."Tenant ID");
//         if Rec."Tenant ID" <> '' then begin
//             isVisible := true;
//         end
//         else begin
//             isVisible := false;
//         end;
//     end;

//     var
//         documentattachment: Codeunit UploadAttachment;
// }