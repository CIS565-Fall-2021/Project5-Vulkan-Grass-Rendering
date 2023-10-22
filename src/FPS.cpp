#include "FPS.h"

#include <iostream>

namespace fps_counter {

FPS::FPS() : _numframes(0) {}

void FPS::start() { _start = high_resolution_clock::now(); }

void FPS::stop() { _end = high_resolution_clock::now(); }

void FPS::update() { ++_numframes; }

double FPS::elapsed() const {
  duration<double> diff = _end - _start;
  return diff.count();
}

double FPS::fps() const { return _numframes / elapsed(); }

void FPS::printFPSMessage() const {
  std::cout << "\tElapsed time: " << elapsed() << std::endl;
  std::cout << "\tAverage FPS: " << fps() << std::endl;
}

}  // namespace fps_counter
