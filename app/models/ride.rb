class Ride < ActiveRecord::Base
    belongs_to :user 
    belongs_to :attraction 
    validates :user_id, presence: true 
    validates :attraction_id, presence: true

    def take_ride
        if report_errors 
            report_errors 
        else  
            tickets = self.user.tickets - self.attraction.tickets 
            happiness = self.user.happiness + self.attraction.happiness_rating 
            nausea = self.user.nausea + self.attraction.nausea_rating  

            self.user.update(tickets: tickets, happiness: happiness, nausea: nausea)
           
        end 
    end 

    private 

        def check_tickets 
            if self.user.tickets < self.attraction.tickets 
                "You do not have enough tickets to ride the #{attraction.name}."
           end
        end 

        def check_height 
            if self.user.height < self.attraction.min_height
                "You are not tall enough to ride the #{attraction.name}."
           end 
        end 

        def report_errors 
            if check_tickets && check_height
             "Sorry. " + check_tickets + " " + check_height 
            elsif check_tickets 
                "Sorry. " + check_tickets
            elsif check_height
                "Sorry. " + check_height 
            end  
        end 


end
