page 50500 "Upload Document List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Document Attachment";
    Caption = 'Document List';


    layout
    {
        area(Content)
        {
            repeater(Group)
            {


                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }

                field("File Extension"; Rec."File Extension")
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
                field("Record No."; Rec."No.")
                {
                    ApplicationArea = All;
                }

                field("Attached Date"; Rec."Attached Date")
                {
                    ApplicationArea = All;
                }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action("Show Property List")
            {

                Caption = 'Show Property List';
                ApplicationArea = All;
                Image = Filter;

                trigger OnAction()
                begin
                    Rec.SetRange("Table Name", 'Property Registration');
                    CurrPage.Update(false);
                end;
            }


        }
    }

    var
        myInt: Integer;
}