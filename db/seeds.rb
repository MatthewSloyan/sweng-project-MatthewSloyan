# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Recipe samples created from: https://www.bbcgoodfood.com/recipes/collection/top-20-main

recipes = [
    {
        :recipe_name => 'Parmesan spring chicken', 
        :description => 'Delicious chicken dinner thats full of spring flavours. The parmesan coating gives a satisfying crunch, and the meat inside stays tender', 
        :difficulty => 'Easy', 
        :servings => 4,
        :cook_time => '20 Minutes',
        # Nest step and ingredients attributes.
        # Code adapted from: https://stackoverflow.com/questions/4419672/how-to-dbseed-a-model-and-all-its-nested-models
        :steps_attributes => [
            { :description => 'Heat grill to medium and line the grill pan with foil.' },
            { :description => 'Beat the egg white on a plate with a little salt and pepper.' },
            { :description => 'Dip the chicken first in egg white, then in the cheese.' },
            { :description => 'Grill the coated chicken for 10-12 mins.' },
            { :description => 'Divide between four warm plates, then serve with the chicken.' }
        ],
        :ingredients_attributes => [
            { :description => '1 egg white' },
            { :description => '5 tbsp grated parmesan' },
            { :description => '4 boneless chicken breasts' },
            { :description => '400g new potatoes' }
        ]
    },
]

recipes.each do |recipe|
  Recipe.create!(recipe)
end

# {
#         :recipe_name => 'Slow roast chicken', 
#         :description => 'Slow-roasting is a great way to keep the chicken nice and moist. Adding the potatoes to the roasting tin infuses them with plenty of flavour, too', 
#         :difficulty => 'Medium', 
#         :servings => 4,
#         :cook_time => '2.5 Hours',
#         :steps => ['Heat oven to 160C/fan. Brush roasting tin and chicken with butter.', 'Place chicken in tin and arrange the potatoes around it.', 'Cook for 1 hr then remove the foil and give the potatoes a shake.', 
#             'Add the herbs, then cook uncovered for 50 mins.', 'Turn the heat up to 220C/fan 200C/gas 7. Cook for 30 mins more.', 'Remove from the pan and leave to rest on a plate for at least 10 mins before carving.', 'Serve with any pan juices.'],
#         :ingredients => ['1.6kg chicken', '1kg roasting potatoes', '100ml chicken stock', '2 stems rosemary', '1 lemon'],
#         :author => 'User_1234'
#     },
#     {
#         :recipe_name => 'Oven-baked risotto', 
#         :description => 'Cook this simple storecupboard risotto in the oven while you get on with something else – the result is still wonderfully creamy', 
#         :difficulty => 'Easy', 
#         :servings => 3,
#         :cook_time => '30 Minutes',
#         :steps => ['Fry the bacon pieces in an ovenproof pan for 3-5 mins until golden and crisp.', 'Stir in the onion and butter and cook for 3-4 mins until soft.', 'Tip in the rice and mix well until coated.', 
#             'Add the cherry tomatoes and the hot stock, then give the rice a stir.', 'Bake for 18 mins until just cooked.', 'Stir through most of the parmesan and serve sprinkled with the remainder.'],
#         :ingredients => ['250g pack smoked bacon', '1 onion', '25g butter', '300g risotto rice', '150g cherry tomatoes', '700ml hot chicken stock', '50g parmesan'],
#         :author => 'User_5678'
#     }