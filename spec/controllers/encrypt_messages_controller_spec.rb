RSpec.describe EncryptMessagesController do

r = Rsa.create({n: 2158, e: 209, d: 1589 })

it "gets by id" do	
	post :create, params:{rsa_id: r.id,message: "pulno 6"}
	expect(response.body).to eq "{\"content\":1}"
end

end
