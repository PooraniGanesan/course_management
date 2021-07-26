require 'rails_helper'

RSpec.describe "Courses", type: :request do


  describe "GET /index" do
    let! (:course) {FactoryBot.create(:course, tutors: [FactoryBot.build(:tutor)])}

    before do 
      get '/courses'
    end
    it "should return success" do
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end


    it "should reuun courses array" do
      expect(JSON.parse(response.body)).to be_instance_of(Array)
    end

    it "return pagination values in headers" do
      expect(response.headers["Per-Page"]).to eq("25")
      expect(response.headers["Total"]).to eq("1")
    end
  end

  describe "GET /index with pagination" do
    let! (:first_course) {FactoryBot.create(:course, tutors: [FactoryBot.build(:tutor)])}
    let! (:second_course) {FactoryBot.create(:course, title: "Testing", tutors: [FactoryBot.build(:tutor, name: "Tutor2"), FactoryBot.build(:tutor, name: "Tutor3")])}
    let! (:third_course) {FactoryBot.create(:course, title: "Design", tutors: [FactoryBot.build(:tutor, name: "Tuto2"), FactoryBot.build(:tutor, name: "Tutor5")])}

    before do
      get '/courses', params: {"page":1, "per_page": 2}
    end

    it "should return paginated headers" do
      expect(response.headers["Total"]).to eq("3")
    end

    it "should return two records" do
      body  = JSON.parse(response.body)
      expect(body.count).to eq(2)
    end
  end


  describe "POST /create" do
    before do
      post '/courses', params: {"course": {"title": "FInal Test1", "tutors_attributes": [{"name": "Poo"}, {"name": "Rani"}]}}
    end

    it "should be successfully created" do
      expect(response).to have_http_status(201)
    end

    it "should respond with id" do
      res = JSON.parse(response.body)
      expect(res.keys).to match_array(["id"])
    end
  end
end
