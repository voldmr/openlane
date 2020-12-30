import pya
from time import sleep

try:
    if output_layout == "":
        raise NameError
    _output_layout = output_layout
except NameError:
    _output_layout = input_layout
    print("Warning: output_layout was not provided; will do the modifications in place!")
    print("Hit CTRL-C to cancel...")
    sleep(3)

print("Starting...")
app = pya.Application.instance()
win = app.main_window()

# Load technology file
tech = pya.Technology()
tech.load(tech_file)
layoutOptions = tech.load_layout_options

# Load def/gds file in the main window
cell_view = win.load_layout(input_layout, layoutOptions, 0)
layout_view = cell_view.view()
layout_view.max_hier()

# gets the corresponding layout object
layout = cell_view.layout()

# gets the cell to change is "INV2X"
# cell = layout.cell("Active_area")
cell = cell_view.cell

# finds source layer
layer, purpose = source_layer.split('/')
assert layer and purpose
_source_layer = layout.layer(int(layer), int(purpose))

# finds (or creates) target layer
layer, purpose = target_layer.split('/')
assert layer and purpose
_target_layer = layout.layer(int(layer), int(purpose))

layout.move_layer(_source_layer, _target_layer)

layout.write(_output_layout)

print("Successfully wrote", _output_layout)

app.exit(0)
