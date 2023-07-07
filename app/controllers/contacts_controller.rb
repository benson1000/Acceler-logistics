class ContactsController < ApplicationController
  def new
    @contact= Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    fullname = @contact.firstName + " " + @contact.lastName
    if @contact.save
      flash[:success] = "Thank you #{fullname} for your comment. We will get back to you shortly."
      redirect_to root_path
    else
      flash[:danger] = "Dear #{fullname} your message has NOT been Sent."
      redirect_to new_contact_path
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:firstName, :lastName, :email, :phoneNumber, :comment)
  end

end
