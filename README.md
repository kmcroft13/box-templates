# Box Templates

Integration with the Box web application that enables users to create templates
of files and folder and copy them into other folders as needed. The integration launches
from the **target** folder, rather than from the source folder, allowing users
to create content directly in the target folder without visiting the source files individually first.

# TODO

-- Scrolling
  -- Make window scrollable even after visiting home page first (CSS conflict with FullPage.js?)
  -- OR
  -- Add scroll bars to each section and auto-calculate section size
  -- FP DESTROY AND REBUILD
-- Update home page with scroll section for slide 2
-- Make feedback button expand to say "Submit Feedback" instead of label
  -- Maybe change to X when clicked (like Amsterdam)?
-- Fix bug when changing dropdown items on "Copy" page
  -- Transition fires multiple times which hides item when it shouldn't
  -- Do a check to see if session variable is set and if so don't fire transition?


-- Standardize colors (specifically the blues)




-- Dynamic renaming
  -- Rename throughout structure? Only certain levels?
-- Enterprise / Group templates
  -- Check if group has access to folder before creating (throw warning if not?)
