import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][20] BS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N-1) {
        auto n = i+1;
        auto b = readln.chomp.to!int - 1;
        BS[b] ~= n;
    }

    int solve(int i) {
        if (BS[i].empty) {
            return 1;
        } else {
            auto max_s = int.min, min_s = int.max;
            foreach (b; BS[i]) {
                auto m = solve(b);
                max_s = max(max_s, m);
                min_s = min(min_s, m);
            }
            return max_s + min_s + 1;
        }
    }

    writeln(solve(0));
}