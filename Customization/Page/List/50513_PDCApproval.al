page 50513 "PDC Approval"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "PDC Approval";
    Caption = 'PDC Approval List';
    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = true;



    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Id; Rec.Id) { Editable = false; }
                field(Status; Rec.Status) { Editable = false; }
                field("PDC Id"; Rec."PDC Id") { Editable = false; }
                field(Tenant_Id; Rec.Tenant_Id) { Editable = false; }
                field(Contract_Id; Rec.Contract_Id) { Editable = false; }
                field(Check_No; Rec.Check_No) { Editable = false; }
                field(Deposite_Bank; Rec.Deposite_Bank) { Editable = false; }
                field(Total_Amount; Rec.Total_Amount) { Editable = false; }
                field(Due_Date; Rec.Due_Date) { Editable = false; }
                field(View; Rec.View)
                {
                    Editable = false;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        FileURL: Text;
                    begin
                        // Get the URL of the uploaded document
                        FileURL := Rec.View;

                        // Check if the file URL is not empty
                        if FileURL = '' then
                            Error('No document is available to view.');

                        // Open the file URL in the browser (new tab)
                        OpenFileInBrowser(FileURL);
                    end;
                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                Caption = 'Approve';
                ApplicationArea = All;
                Image = Approve;

                trigger OnAction()
                var
                    pdcTransactionRec: Record "PDC Transaction";
                begin
                    if Rec.Status = 'Pending' then begin
                        Rec.Status := 'Approve';
                        Rec.Modify();
                        Commit();

                        pdcTransactionRec.SetRange("PDC ID", Rec."PDC Id");
                        if pdcTransactionRec.FindSet() then begin
                            pdcTransactionRec."Approval Status" := pdcTransactionRec."Approval Status"::Approved;
                            pdcTransactionRec.Modify();
                        end;

                        Message('Changes action is "Approve".'); // Success message for approve action
                        CurrPage.Update();
                    end else
                        Message('Selected record is not in "Pending" status.');
                end;
            }

            action(Reject)
            {
                Caption = 'Reject';
                ApplicationArea = All;
                Image = Reject;

                trigger OnAction()
                begin
                    if Rec.Status = 'Pending' then begin
                        Rec.Status := 'Declined';
                        Rec.Modify();
                        Commit();
                        Message('Changes action is "Reject".'); // Success message for reject action
                        CurrPage.Update();
                    end else
                        Message('Selected record is not in "Pending" status.');
                end;
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

    var
        myInt: Integer;
}