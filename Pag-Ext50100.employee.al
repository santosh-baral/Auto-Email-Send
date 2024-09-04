pageextension 50100 employee extends "Employee Card"
{
    actions
    {
        addafter("E&mployee")
        {
            action("Send Employee INFO")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Email;
                trigger OnAction()
                var
                    InStream: InStream;
                    Body: text;
                    TenantMedia: Record "Tenant Media";
                    Recipients: List of [Text];
                    DocumentAttachment: Record "Document Attachment";
                    EmailMsg: CodeUnit "Email Message";
                    EmailObj: CodeUnit Email;
                    EmailSubject: Label 'Information of Employee.';
                    EmailBody: Label 'Dear Manager<br><br>The Name of Employee is<font color="red"><strong>%1.</strong></font> <br>Address: <strong>%2</strong>.<br> Date of Birth <strong>%3</strong>.';
                begin
                    Body := StrSubstNo(EmailBody, Rec.FullName(), Rec.Address, rec."Birth Date");
                    Recipients.Add('santoshbaral258@gmail.com');
                    EmailMsg.Create(Recipients, EmailSubject, Body, true);
                    TenantMedia.Get(Rec.Image.MediaId);
                    TenantMedia.CalcFields(Content);
                    TenantMedia.Content.CreateInStream(InStream);
                    EmailMsg.AddAttachment('employee.jpeg', 'jpg', InStream);
                    if EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default) then
                        Message('Email is Send Successfully');
                end;
            }
        }
    }
}
