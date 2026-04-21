class Users::SessionsController < Devise::SessionsController
  # DELETE /users/sign_out
  def destroy
    super do
      # Turbo が 302 を誤解して GET /users/sign_out を発生させるため
      return redirect_to root_path, status: :see_other
    end
  end
end
