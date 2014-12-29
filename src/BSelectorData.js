var choices = {
    '1_single_elim' : {
        caption : "Single Elimination",
        winCount: function(count){
            return Math.round(count/2);
        },
        isEnabled: function(count){
            return count>=2;
        }
    },
    '2_double_elim' : {
        caption : "Double Elimination",
        winCount: function(count){
            return Math.round(count/3);
        },
        isEnabled: function(count){
            return count>=6;
        }
    },
    '3_group' : {
        caption : "Group",
        winCount: function(count){
            return count;
        },
        isEnabled: function(count){
            return count>=4;
        }
    },
    '4_group_4_4' : {
        caption : "Group 4 x 4: 2 winnners",
        winCount: function(count){
            return 8;
        },
        isEnabled: function(count){
            return count===16;
        }
    }

};


