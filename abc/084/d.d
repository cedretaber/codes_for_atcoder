import std.stdio, std.algorithm, std.conv, std.array, std.string;

bool[10^^5+1] PRM = true;
int[10^^5+1] BIT;

void main()
{
    PRM[0] = PRM[1] = false;
    foreach (i; 3..10^^5+1) {
        if (i & 1) {
            if (PRM[i]) {
                auto n = 2;
                auto j = i * n;
                while (j < 10^^5+1) {
                    PRM[j] = false;
                    j = i * (n++);
                }
            }
        } else {
            PRM[i] = false;
        }
    }

    foreach (n; 3..10^^5+1) {
        if (PRM[n] && PRM[(n+1)/2]) {
            for (auto x = n; x <= 10^^5; x += x & -x) {
                BIT[x] += 1;
            }
        }
    }

    int sum(int a) {
        int ret;
        for (auto x = a; x > 0; x -= x & -x) {
            ret += BIT[x];
        }
        return ret;
    }

    auto q = readln.chomp.to!int;
    foreach (_; 0..q) {
        auto lr = readln.split.to!(int[]);
        writeln(sum(lr[1]) - sum(lr[0]-1));
    }
}