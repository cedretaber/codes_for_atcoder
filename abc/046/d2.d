import std.stdio, std.algorithm, std.conv, std.array, std.string;

int[int][10^^5 + 1] MEMO;

void main()
{
    auto s = readln.chomp;
    int v, p;

    foreach (gp; s) {
        switch (gp) {
            case 'g':
                if (p == 0) {
                    ++p;
                } else {
                    --p;
                    ++v;
                }
                break;
            case 'p':
                if (p == 0) {
                    --v;
                    ++p;
                } else {
                    --p;
                }
                break;
            default:
        }
    }

    writeln(v);
}