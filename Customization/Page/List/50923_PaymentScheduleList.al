page 50923 "Payment Schedule List"
{
    PageType = List;
    SourceTable = "Payment Schedule";
    ApplicationArea = All;
    Caption = 'Payment Schedule List';
    UsageCategory = Lists;
    CardPageId = 50921;


    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Contract ID"; Rec."Contract ID")
                {
                    ApplicationArea = All;
                    Caption = 'Contract_ID';
                }
                // field("Proposal ID"; Rec."Proposal ID")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Proposal ID';
                // }

                field("Tenant ID"; Rec."Tenant ID")
                {
                    ApplicationArea = All;
                    Caption = 'Tenant ID';
                }
                // field("Total Amount Including VAT"; Rec."Total Amount Including VAT")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Total Amount Including VAT';

                // }


            }
        }
    }

}
