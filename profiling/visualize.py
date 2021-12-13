import numpy as np
from matplotlib import pyplot as plt

if __name__ == '__main__':
  # tested with NUM_BlADES = 2^18
  culling_options = [
      'No Culling', 'Orientation', 'View-Frustum', 'Distance', 'All'
  ]
  average_fps = [42.9923, 676.976, 60.5593, 131.072, 677.941]

  plt.figure()
  bars = plt.bar(culling_options, average_fps)
  plt.xlabel('Culling Options')
  plt.ylabel('Average FPS')
  plt.title('Average FPS vs. Culling Options (Larger is Better)')

  for bar in bars:
    yval = bar.get_height()
    plt.text(bar.get_x(), yval + 10, yval)

  plt.show()
