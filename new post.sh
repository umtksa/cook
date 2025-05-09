#!/bin/bash

# Clear the screen
clear

# Define the save location
save_location=""

# Prompt the user for the recipe name
read -p "What is the name of recipe? " recipe_name

# Replace spaces with hyphens in the recipe name
recipe_title="${recipe_name// /-}"

# Define an array of categories
categories=("soup" "deserts" "other")

# Clear the screen
clear

# Prompt the user to select a category
echo "Choose a category for $recipe_name"
select category in "${categories[@]}"; do
  if [[ " ${categories[@]} " =~ " $category " ]]; then
    # Category is valid
    break
  else
    echo "opps! try again please."
  fi
done

# Clear the screen
clear

# Prompt the user for the number of servings
read -p "number of serving for $recipe_name: " servings

# Prompt the user for the preparation time in minutes
read -p "Preperation time for $recipe_name in minutes: " prep_time


# Initialize an empty ingredients list
ingredients=""

# Clear the screen
clear

# Prompt the user for ingredients until they choose to stop (by pressing Enter)
echo "what are the ingredients for $recipe_name (enter when done)"
while read -r ingredient; do
  if [ -z "$ingredient" ]; then
    break
  fi
  # Add each ingredient as a new line
  ingredients+="    * $ingredient"$'\n'
done

# Clear the screen
clear

# Initialize an empty directions list
directions=""

# Initialize a direction counter
direction_count=1

# Prompt the user for directions until they choose to stop (by pressing Enter)
echo "what are the directions for $recipe_name (enter when done)"
while read -r direction; do
  if [ -z "$direction" ]; then
    break
  fi
  # Add each direction as a new line
  directions+="    $direction_count. $direction"$'\n'
  ((direction_count++))
done

# Define the file name for the generated Markdown file
output_file="$save_location$(date +'%Y-%m-%d')-$recipe_title.md"

# Define the content of the Markdown file
markdown_content="---
date: $(date +'%Y-%m-%d')
title: $recipe_name
permalink: $recipe_title
categories:
  - $category

recipe:
  servings: $servings 
  prep: $prep_time minutes
  ingredients_markdown: |-
$ingredients
  directions_markdown: |-
$directions
---"

# Write the content to the output file
echo "$markdown_content" > "$output_file"
echo -n "$markdown_content" | pbcopy
echo copy done


echo "Recipe Generated As: $output_file"
