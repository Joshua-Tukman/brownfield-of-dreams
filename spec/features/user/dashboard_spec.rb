require 'rails_helper'
RSpec.describe "As a user" do
    describe "when I visit /dashboard" do
        describe "I see a link to login with OAuth" do 
            it "allows me to login through Github" do 
                user = create(:user)
                allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
                
                visit '/dashboard'

                expect(page).to_not have_content("Github Repos:")
                #click_link "Connect with Github"

            end
        end  
        
        describe "when I have a github token stored in the db" do

            it "shows a section for 'Github' with a list of 5 repos underneath" do
                user = create(:user)
                user2 = create(:user)
                user.token = ENV["GITHUB_TOKEN"]
                user2.token = ENV["JESSE_GITHUB_TOKEN"]
                allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)  
        
                visit '/dashboard'

                expect(page).to have_content("Github Repos:") 
                expect(page).to have_css("a.repos", count: 5)
            end

            it "it shows a section for followers within the Github section of page" do
                user = create(:user)
                user2 = create(:user)
                user.token = ENV["GITHUB_TOKEN"]
                user2.token = ENV["JESSE_GITHUB_TOKEN"]

                allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) 
                
                visit '/dashboard' 

                expect(page).to have_content("Followers")
                expect(page).to have_css("a.followers")
            end

            it "it shows a section for people user is following within the Github section of page" do
                user = create(:user)
                user2 = create(:user)
                user.token = ENV["GITHUB_TOKEN"]
                user2.token = ENV["JESSE_GITHUB_TOKEN"]

                allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) 
                
                visit '/dashboard' 

                expect(page).to have_content("Following")
                expect(page).to have_css("a.following")
            end
        end

        describe "when I DO NOT have a github token stored in the db" do

            it "it doesn't show Github section" do
                user = create(:user)
                
                allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)  
        
                visit '/dashboard'

                expect(page).to_not have_content("Github Repos:") 
                expect(page).to_not have_css("a.repos", count: 5)
            end        
        end

        describe "when I am logged in" do
            it "I should see a list of all bookmarked segments under the Bookmarked Segments section" do
                user = create(:user)

                tutorial1= create(:tutorial, title: "How to Tie Your Shoes")
                tutorial2= create(:tutorial, title: "How to Make Toast")
                tutorial3= create(:tutorial, title: "How to Make Your Bed")

                video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial1)
                video2 = create(:video, title: "Always Make a Double Knot", tutorial: tutorial1, position: 1)
                video3 = create(:video, title: "Wheat Bread is the Best!", tutorial: tutorial2, position: 1)
                video4 = create(:video, title: "Use Real Butter", tutorial: tutorial2)
                video5 = create(:video, title: "Butter Knives are Dangerous", tutorial: tutorial2, position: 2)
                video6 = create(:video, title: "Fluff your Pillow", tutorial: tutorial3, position: 1)
                video7 = create(:video, title: "Clean Sheets are Best", tutorial: tutorial3)

                UserVideo.create!(user_id: user.id, video_id: video1.id)
                UserVideo.create!(user_id: user.id, video_id: video6.id)
                UserVideo.create!(user_id: user.id, video_id: video2.id)
                UserVideo.create!(user_id: user.id, video_id: video7.id)
                UserVideo.create!(user_id: user.id, video_id: video3.id)
                UserVideo.create!(user_id: user.id, video_id: video4.id)
                             
                allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
                           
                visit '/dashboard'
                expect(page).to have_content("Bookmarked Segments")

                within ".tutorial-#{tutorial1.id}" do
                    within ".video-0" do 
                        expect(page).to have_link(video1.title)
                    end 
                    within ".video-1" do 
                        expect(page).to have_link(video2.title)
                    end 
                end 

                within ".tutorial-#{tutorial2.id}" do
                    within ".video-0" do 
                        expect(page).to have_link(video4.title)
                    end 
                    within ".video-1" do 
                        expect(page).to have_link(video3.title)
                    end 
                    expect(page).to_not have_link(video5.title)
                end 

                within ".tutorial-#{tutorial3.id}" do
                    within ".video-0" do 
                        expect(page).to have_link(video7.title)
                    end 
                    within ".video-1" do 
                        expect(page).to have_link(video6.title)
                    end 
                end 
            end
        end
    end
end
# As a logged in user
# When I visit '/dashboard'
# Then I should see a list of all bookmarked segments under the Bookmarked Segments section
# And they should be organized by which tutorial they are a part of
# And the videos should be ordered by their position