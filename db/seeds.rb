# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# 5 Recipe samples created from: https://www.bbcgoodfood.com/recipes/collection/top-20-main
recipes = [
    {
        :recipe_name => 'Parmesan spring chicken', 
        :description => 'Delicious chicken dinner thats full of spring flavours. The parmesan coating gives a satisfying crunch, and the meat inside stays tender', 
        :difficulty => 'Easy',
        :servings => 4,
        :cook_time => 20,
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
    {
        :recipe_name => 'Slow roast chicken', 
        :description => 'Slow-roasting is a great way to keep the chicken nice and moist. Adding the potatoes to the roasting tin infuses them with plenty of flavour, too', 
        :difficulty => 'Medium', 
        :servings => 4,
        :cook_time => 100,
        :steps_attributes => [
            { :description => 'Heat oven to 160C/fan. Brush roasting tin and chicken with butter.' },
            { :description => 'Place chicken in tin and arrange the potatoes around it.' },
            { :description => 'Cook for 1 hr then remove the foil and give the potatoes a shake.' },
            { :description => 'Add the herbs, then cook uncovered for 50 mins.' },
            { :description => 'Turn the heat up to 220C/fan 200C/gas 7. Cook for 30 mins more, then serve.' }
        ],
        :ingredients_attributes => [
            { :description => '1.6kg chicken' },
            { :description => '1kg roasting potatoes' },
            { :description => '100ml chicken stock' },
            { :description => '2 stems rosemary' }
        ]
    },
    {
        :recipe_name => 'Oven-baked risotto', 
        :description => 'Cook this simple storecupboard risotto in the oven while you get on with something else – the result is still wonderfully creamy', 
        :difficulty => 'Hard', 
        :servings => 3,
        :cook_time => 70,
        :steps_attributes => [
            { :description => 'Heat oven to 160C/fan. Brush roasting tin and chicken with butter.' },
            { :description => 'Place chicken in tin and arrange the potatoes around it.' },
            { :description => 'Cook for 1 hr then remove the foil and give the potatoes a shake.' },
            { :description => 'Add the herbs, then cook uncovered for 50 mins.' },
            { :description => 'Turn the heat up to 220C/fan 200C/gas 7. Cook for 30 mins more, then serve.' }
        ],
        :ingredients_attributes => [
            { :description => '250g pack smoked bacon' },
            { :description => '1 onion' },
            { :description => '25g butter' },
            { :description => '300g risotto rice' },
            { :description => '700ml hot chicken stock' },
            { :description => '50g parmesan'] }
        ]
    },
    {
        :recipe_name => 'Pizza', 
        :description => 'Make your own pizza with a crispy base, mozzarella cheese and a fresh tomato sauce. Add simple toppings like slices of ham and rocket if you like.', 
        :difficulty => 'Easy',
        :servings => 6,
        :cook_time => 20,
        :steps_attributes => [
            { :description => 'Roll dough into desired shape.' },
            { :description => 'Add tomato sauce and then cheese.' },
            { :description => 'Cook for between 10-15 mins depending on your oven temp, until the base is crisp and the cheese melted. ' }
        ],
        :ingredients_attributes => [
            { :description => '375g Italian flour' },
            { :description => 'Mozzarella Cheese' },
            { :description => 'Fresh Tomato sauce' },
        ]
    },
    {
        :recipe_name => 'Sponge cake', 
        :description => 'Choose your favourite filling for this easy sponge cake – we have opted for lemon curd and whipped cream, but you could have jam. Perfect for afternoon tea', 
        :difficulty => 'Medium',
        :servings => 8,
        :cook_time => 30,
        :steps_attributes => [
            { :description => 'Heat oven to 180C/160C, butter and line the base of two 20cm spring-form cake tins' },
            { :description => 'Whisk the butter and sugar together until fluffy. Crack the eggs in one at a time.' },
            { :description => 'Bake in the centre of the oven for 25-30 mins' },
            { :description => 'After 10 mins remove the cakes from their tins and leave to cool.' }
        ],
        :ingredients_attributes => [
            { :description => '225g softened butter' },
            { :description => '4 large eggs' },
            { :description => '225g golden caster sugar' },
            { :description => '225g self-raising flour' }
        ]
    },
]

# Users to login with.
users = [
    { :name => 'Matthew', username: 'Test_Author', email: 'test@gmail.com', password: 'test1234', password_confirmation: 'test1234'},
    { :name => 'John Doe', username: 'John_Doe', email: 'john@gmail.com', password: 'test1234', password_confirmation: 'test1234'},
]

# Create recipes and users.
recipes.each do |recipe|
  Recipe.create!(recipe)
end

users.each do |user|
  User.create!(user)
end