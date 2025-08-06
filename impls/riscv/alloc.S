	# This file contain the fonctions necessary to allocate and free memory
	# for this implementation.

	# Global fonctions:
	# - alloc_item
	# - free_item
	
	# Function list:
	# - alloc_item
	# - free_item
	# - alloc_mem_struct
	# - free_mem_struct
	
	# List will be linked forward and backward
	# (simplier in the ways things can be done)
	# The memory management sheme will be the following:
	# | item 1 | item 2 | item 3 |
	# We add item 4:
	# | item 1 | item 2 | item 3 | item 4 |
	# We remove item 2:
	# | item 1 | item 4 | item 3 |
	# It is done by following the number of items and
	# by updating links between the items.
	# We allocate the buffer containing the lists with mmap
	# When there is not enough space, we allocate another one
	# We use munmap to free the space

	# We well use list to store everything like strings
	# (a string will be a list of chars)
	# It will be easier since like that we will not need another memory scheme

	.section .text
	.global alloc_item
	.global free_item

	# ret: addr of the allocated item 
alloc_item:
	ret

	# param: addr of the item to free
free_item:
	ret
