require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end

   #exercise 10.5.1
      describe "the sidebar micropost counts" do
        describe "one posting" do
          before do 
            FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
            sign_in user
            visit root_path
          end

          it { should have_content("1 micropost") }
        end

       describe "two postings" do
          before do 
            FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
	    FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum 2")
            sign_in user
            visit root_path
          end

          it { should have_content("2 microposts") }
        end
end

	#Exercise 10.5.2
	describe "pagination" do
         describe "more than one page" 
	 before do 
           31.times{ FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")}
            sign_in user
            visit root_path
          end
          it {should have_selector("div.pagination") }
          it {should have_selector("li.prev.previous_page")}
	end
	describe "one page only" do
	before do 
           10.times{ FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")}
            sign_in user
            visit root_path
          end
          it {should_not have_selector("div.pagination") }
          it {should_not have_selector("li.prev.previous_page")}
	end
	end

	#exercise 10.5.4
	describe "delete links" do
	#the created user posts some microposts
	before do 
           10.times{ FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")}

	#second user created
	@attr = { :name => "Second User",
          :email => "user@example.com",
           :password => "foobar",
           :password_confirmation => "foobar" }
         @second_user = FactoryGirl.create(:user, @attr)     

	#second user signs in and navigates to the first users profile
	   sign_in @second_user
           get root_path, :id => user
	end
	#no way to delete
	it {should_not have_selector("a", :text => "delete")}
	end

end



