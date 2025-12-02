class ContactsController < ApplicationController

	def show
    @faqs = Question.all
	end

  def create
		@success = false
		@contact = Contact.new(params_contact)

		if @contact.valid?
			unless @contact.use_v2.blank?
				unless Mill::Recaptcha.verify_recaptcha_v2?(params['g-recaptcha-response'], 'contact')
					flash[:alert] = t('global.recaptcha_failed')
					@show_recaptcha_v2 = true
				else
					create_data
				end
			else
				unless Mill::Recaptcha.verify_recaptcha?(params[:recaptcha_token], 'contact')
					flash[:alert] = t('global.recaptcha_failed')
					@show_recaptcha_v2 = true
				else
					create_data
				end
			end
		else
			flash[:alert] = t('inquiries.errors')
		end

    respond_to do |format|
      format.js
    end
  end

  private

  def params_contact
    params.require(:contact).permit(:name, :email, :phone, :message, :subject, :use_v2)
  end

	def create_data
		if @contact.save
			flash[:notice] = t('inquiries.success')
			@success = true
			@contact = Contact.new
		else
			flash[:alert] = t('inquiries.errors')
		end
	end
end
