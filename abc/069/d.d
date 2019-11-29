import std.stdio, std.algorithm, std.conv, std.array, std.string;

int[100][100] HW;
int H, W, N;

void main()
{
    auto hw = readln.split.to!(int[]);
    H = hw[0];
    W = hw[1];
    N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);

    size_t x, y;
    foreach (i, a; as) {
        ++i;
        while(a--) {
            HW[y][x] = i.to!int;
            if (y%2 == 0) {
                if (++x == W) {
                    --x;
                    ++y;
                }
            } else {
                if (--x == -1) {
                    ++x;
                    ++y;
                }
            }
        }
    }

    foreach (line; HW[0..H].dup.map!(line => line.dup[0..W].to!(string[])))
        writeln(line.join(" "));
}