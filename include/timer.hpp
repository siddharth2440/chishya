#pragma once

#include <chrono>
#include <cstdint>


class Timer {

    private:
        using Clock = std::chrono::steady_clock;
        Clock::time_point start_;

    public:
        Timer() : start_{ Clock::now() } {}

        [[nodiscard]]
        double elapsed_ms() const noexcept {
            const auto elapsed = Clock::now() - start_;
            return std::chrono::duration<double, std::milli>(elapsed).count();
        }

};