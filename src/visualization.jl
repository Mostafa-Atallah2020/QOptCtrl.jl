function visualise_pulses(init_ctrl_arr, final_ctrl_arr)
        fig_init = plot(vec(init_ctrl_arr), linetype=:steppre, label="initial guess", lc=:red, xlabel="time")
        fig_final = plot(vec(final_ctrl_arr), linetype=:steppre, label="optimal pulses", lc=:blue, xlabel="time")

        fig = plot(fig_init, fig_final, layout = (2, 1))
        #savefig(fig, "fig.png")
end
