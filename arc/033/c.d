import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

bool[200000] NS;
int[500] CS;

void main()
{
    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto tx = readln.split.to!(int[]);
        auto X = tx[1];
        if (tx[0] == 1) {
            X -= 1;
            NS[X] = true;
            ++CS[X/500];
        } else {
            int n;
            foreach (i, c; CS) {
                n += c;
                if (n >= X) {
                    n -= c;
                    --CS[i];
                    i *= 500;
                    for (;;) {
                        if (NS[i]) ++n;
                        if (n == X) {
                            writeln(i+1);
                            NS[i] = false;
                            break;
                        }
                        ++i;
                    }
                    break;
                }
            }
        }
    }
}