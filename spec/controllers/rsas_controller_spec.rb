RSpec.describe RsasController do

it "gets by id" do
	post :create, params:{n: 2158, e: 209, d: 1589}
	get :show, params:{id: 1}
	expect(response.body).to eq "{\"n\":2158,\"e\":209,\"d\":1589}"
end

end
