import numpy as np
import matplotlib.pyplot as plt
from cmdstanpy import cmdstan_path, CmdStanModel


LIGHT = "#DCBCBC"
LIGHT_HIGHLIGHT = "#C79999"
MID = "#B97C7C"
MID_HIGHLIGHT = "#A25050"
DARK = "#8F2727"
DARK_HIGHLIGHT = "#7C0000"


def run_stan_model(stan_file, data, **kwargs):
    """
    Convenience function to compile, sample and diagnose a Stan model.
    
    Notes
    -----
    For prior predictive sampling (or to otherwise
    simulate data), pass `fixed_param=True`.
    https://cmdstanpy.readthedocs.io/en/latest/sample.html#example-generate-data-fixed-param-true
    """
    model = CmdStanModel(stan_file=stan_file)
    model.compile()
    fit = model.sample(data=data, **kwargs)
    fit.diagnose()
    return model, fit


def plot_percentiles(
    data,
    ax=None,
    title=None,
    xlim=None,
    ylim=None,
    xlabel=None,
    ylabel=None,
    xoffset=None,
):
    """
    Parameters
    ----------
    data : np.array
        Each row is one series of data to plot.
    """

    if ax is None:
        _, ax = plt.subplots(figsize=[12, 6])
    if xoffset is None:
        xoffset = 0

    xs = xoffset + np.arange(data.shape[1])
    probs = [10, 20, 30, 40, 50, 60, 70, 80, 90]
    percentiles = np.vstack([np.percentile(column, probs) for column in data.T]).T

    ax.fill_between(
        xs, percentiles[0], percentiles[8], facecolor=LIGHT, color=LIGHT,
    )
    ax.fill_between(
        xs,
        percentiles[1],
        percentiles[7],
        facecolor=LIGHT_HIGHLIGHT,
        color=LIGHT_HIGHLIGHT,
    )
    ax.fill_between(
        xs, percentiles[2], percentiles[6], facecolor=MID, color=MID,
    )
    ax.fill_between(
        xs,
        percentiles[3],
        percentiles[5],
        facecolor=MID_HIGHLIGHT,
        color=MID_HIGHLIGHT,
    )
    ax.plot(xs, percentiles[4], color=DARK)

    if title is not None:
        ax.set_title(title)
    if xlabel is not None:
        ax.set_xlabel(xlabel)
    if ylabel is not None:
        ax.set_ylabel(ylabel)
    if xlim is not None:
        ax.set_xlim(xlim)
    if ylim is not None:
        ax.set_ylim(ylim)

    return ax
