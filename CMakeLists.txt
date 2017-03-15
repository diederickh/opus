cmake_minimum_required(VERSION 3.7)
project(opus)
set(bd ${CMAKE_CURRENT_LIST_DIR})

# -------------------------------------------
#
# Experimental CMake script for the opus
# codec. I've created this script to make
# cross platform usage of Opus a lot easier,
# especially when building for Windows and
# different Visual Studio versions.
#
# Below I've added `##` after every line which
# was part of the MSVC solution file.
#
# -------------------------------------------

set(opus_sources

  # Opus
  ${bd}/src/analysis.c ##
  ${bd}/src/mlp.c ##
  ${bd}/src/mlp_data.c ##
  #${bd}/src/mlp_train.c ## --- not in win32
  ${bd}/src/opus.c ##
  ${bd}/src/opus_compare.c ##
  ${bd}/src/opus_decoder.c ##
  #${bd}/src/opus_demo.c
  ${bd}/src/opus_encoder.c ##
  ${bd}/src/opus_multistream.c ##
  ${bd}/src/opus_multistream_decoder.c ## 
  ${bd}/src/opus_multistream_encoder.c ##
  ${bd}/src/repacketizer.c ##
  #${bd}/src/repacketizer_demo.c

  # Silk
  ${bd}/silk/A2NLSF.c ##
  ${bd}/silk/CNG.c ##
  ${bd}/silk/HP_variable_cutoff.c ## 
  ${bd}/silk/LPC_analysis_filter.c ##
  ${bd}/silk/LPC_fit.c ## 
  ${bd}/silk/LPC_inv_pred_gain.c ##
  ${bd}/silk/LP_variable_cutoff.c ##
  ${bd}/silk/NLSF2A.c  ##
  ${bd}/silk/NLSF_VQ.c ##
  ${bd}/silk/NLSF_VQ_weights_laroia.c ##
  ${bd}/silk/NLSF_decode.c ##
  ${bd}/silk/NLSF_del_dec_quant.c ##
  ${bd}/silk/NLSF_encode.c ##
  ${bd}/silk/NLSF_stabilize.c ##
  ${bd}/silk/NLSF_unpack.c ##
  ${bd}/silk/NSQ.c ##
  ${bd}/silk/NSQ_del_dec.c ##
  ${bd}/silk/PLC.c ##
  ${bd}/silk/VAD.c ##
  ${bd}/silk/VQ_WMat_EC.c ##
  ${bd}/silk/ana_filt_bank_1.c ##
  ${bd}/silk/biquad_alt.c ##
  ${bd}/silk/bwexpander.c ##
  ${bd}/silk/bwexpander_32.c ##
  ${bd}/silk/check_control_input.c ##
  ${bd}/silk/code_signs.c ##
  ${bd}/silk/control_SNR.c ##
  ${bd}/silk/control_audio_bandwidth.c ##
  ${bd}/silk/control_codec.c ##
  ${bd}/silk/debug.c ##
  ${bd}/silk/dec_API.c ##
  ${bd}/silk/decode_core.c ##
  ${bd}/silk/decode_frame.c ##
  ${bd}/silk/decode_indices.c ##
  ${bd}/silk/decode_parameters.c ##
  ${bd}/silk/decode_pitch.c ## 
  ${bd}/silk/decode_pulses.c ##
  ${bd}/silk/decoder_set_fs.c ##
  ${bd}/silk/enc_API.c ##
  ${bd}/silk/encode_indices.c ##
  ${bd}/silk/encode_pulses.c ##
  ${bd}/silk/gain_quant.c ##
  ${bd}/silk/init_decoder.c ##
  ${bd}/silk/init_encoder.c ##
  ${bd}/silk/inner_prod_aligned.c ##
  ${bd}/silk/interpolate.c ##
  ${bd}/silk/lin2log.c ##
  ${bd}/silk/log2lin.c ##
  ${bd}/silk/pitch_est_tables.c ##
  ${bd}/silk/process_NLSFs.c ##
  ${bd}/silk/quant_LTP_gains.c
  ${bd}/silk/resampler.c ##
  ${bd}/silk/resampler_down2.c ##
  ${bd}/silk/resampler_down2_3.c ##
  ${bd}/silk/resampler_private_AR2.c ##
  ${bd}/silk/resampler_private_IIR_FIR.c  ##
  ${bd}/silk/resampler_private_down_FIR.c ##
  ${bd}/silk/resampler_private_up2_HQ.c ##
  ${bd}/silk/resampler_rom.c ##
  ${bd}/silk/shell_coder.c ##
  ${bd}/silk/sigm_Q15.c ##
  ${bd}/silk/sort.c ##
  ${bd}/silk/stereo_LR_to_MS.c ##
  ${bd}/silk/stereo_MS_to_LR.c ## 
  ${bd}/silk/stereo_decode_pred.c ##
  ${bd}/silk/stereo_encode_pred.c ##
  ${bd}/silk/stereo_find_predictor.c ##
  ${bd}/silk/stereo_quant_pred.c ##
  ${bd}/silk/sum_sqr_shift.c ## 
  ${bd}/silk/table_LSF_cos.c ##
  ${bd}/silk/tables_LTP.c ## 
  ${bd}/silk/tables_NLSF_CB_NB_MB.c ##
  ${bd}/silk/tables_NLSF_CB_WB.c ##
  ${bd}/silk/tables_gain.c ##
  ${bd}/silk/tables_other.c ##
  ${bd}/silk/tables_pitch_lag.c ##
  ${bd}/silk/tables_pulses_per_block.c ##

  # Silk fixed
  ${bd}/silk/fixed/LTP_analysis_filter_FIX.c ##
  ${bd}/silk/fixed/LTP_scale_ctrl_FIX.c ##
  ${bd}/silk/fixed/apply_sine_window_FIX.c ##
  ${bd}/silk/fixed/autocorr_FIX.c ##
  ${bd}/silk/fixed/burg_modified_FIX.c ## 
  ${bd}/silk/fixed/corrMatrix_FIX.c ##
  ${bd}/silk/fixed/encode_frame_FIX.c ##
  ${bd}/silk/fixed/find_LPC_FIX.c ##
  ${bd}/silk/fixed/find_LTP_FIX.c ##
  ${bd}/silk/fixed/find_pitch_lags_FIX.c ##
  ${bd}/silk/fixed/find_pred_coefs_FIX.c ##
  ${bd}/silk/fixed/k2a_FIX.c ##
  ${bd}/silk/fixed/k2a_Q16_FIX.c ##
  ${bd}/silk/fixed/noise_shape_analysis_FIX.c ##
  ${bd}/silk/fixed/pitch_analysis_core_FIX.c ##
  ${bd}/silk/fixed/process_gains_FIX.c ##
  ${bd}/silk/fixed/regularize_correlations_FIX.c ##
  ${bd}/silk/fixed/residual_energy16_FIX.c  ## 
  ${bd}/silk/fixed/residual_energy_FIX.c ##
  ${bd}/silk/fixed/schur64_FIX.c ##
  ${bd}/silk/fixed/schur_FIX.c ##
  ${bd}/silk/fixed/vector_ops_FIX.c ##
  ${bd}/silk/fixed/warped_autocorrelation_FIX.c ##

  # Silk x86
  ${bd}/silk/x86/NSQ_del_dec_sse.c ##
  ${bd}/silk/x86/NSQ_sse.c  ##
  ${bd}/silk/x86/VAD_sse.c ##
  ${bd}/silk/x86/VQ_WMat_EC_sse.c ##
  ${bd}/silk/x86/x86_silk_map.c ##


  # Silk fixed x86
  ${bd}/silk/fixed/x86/burg_modified_FIX_sse.c ##
  ${bd}/silk/fixed/x86/prefilter_FIX_sse.c ##
  ${bd}/silk/fixed/x86/vector_ops_FIX_sse.c ## 

  # Silk float
  ${bd}/silk/float/LPC_analysis_filter_FLP.c ##
  ${bd}/silk/float/LPC_inv_pred_gain_FLP.c  ##
  ${bd}/silk/float/LTP_analysis_filter_FLP.c ##
  ${bd}/silk/float/LTP_scale_ctrl_FLP.c ##
  ${bd}/silk/float/apply_sine_window_FLP.c ## 
  ${bd}/silk/float/autocorrelation_FLP.c ##
  ${bd}/silk/float/burg_modified_FLP.c ##
  ${bd}/silk/float/bwexpander_FLP.c  ##
  ${bd}/silk/float/corrMatrix_FLP.c ##
  ${bd}/silk/float/encode_frame_FLP.c ##
  ${bd}/silk/float/energy_FLP.c ##
  ${bd}/silk/float/find_LPC_FLP.c ##
  ${bd}/silk/float/find_LTP_FLP.c ##
  ${bd}/silk/float/find_pitch_lags_FLP.c ##
  ${bd}/silk/float/find_pred_coefs_FLP.c ##
  ${bd}/silk/float/inner_product_FLP.c ##
  ${bd}/silk/float/k2a_FLP.c ##
  ${bd}/silk/float/noise_shape_analysis_FLP.c ##
  ${bd}/silk/float/pitch_analysis_core_FLP.c ##
  ${bd}/silk/float/process_gains_FLP.c ## 
  ${bd}/silk/float/regularize_correlations_FLP.c ##
  ${bd}/silk/float/residual_energy_FLP.c ##
  ${bd}/silk/float/scale_copy_vector_FLP.c ##
  ${bd}/silk/float/scale_vector_FLP.c ##
  ${bd}/silk/float/schur_FLP.c ##
  ${bd}/silk/float/sort_FLP.c ##
  ${bd}/silk/float/warped_autocorrelation_FLP.c ##
  ${bd}/silk/float/wrappers_FLP.c ##


  # Celt
  ${bd}/celt/bands.c ##
  ${bd}/celt/celt.c ##
  ${bd}/celt/celt_decoder.c ##
  ${bd}/celt/celt_encoder.c ## 
  ${bd}/celt/celt_lpc.c ## 
  ${bd}/celt/cwrs.c ##
  ${bd}/celt/entcode.c ##
  ${bd}/celt/entdec.c ##
  ${bd}/celt/entenc.c ##
  ${bd}/celt/kiss_fft.c ##
  ${bd}/celt/laplace.c ##
  ${bd}/celt/mathops.c ##
  ${bd}/celt/mdct.c ##
  ${bd}/celt/modes.c  ##
  #${bd}/celt/opus_custom_demo.c
  ${bd}/celt/pitch.c ##
  ${bd}/celt/quant_bands.c ##
  ${bd}/celt/rate.c ##
  ${bd}/celt/vq.c ##

  # Celt x86
  ${bd}/celt/x86/celt_lpc_sse.c ##
  ${bd}/celt/x86/pitch_sse.c ##
  ${bd}/celt/x86/pitch_sse2.c ## 
  ${bd}/celt/x86/pitch_sse4_1.c ##
  ${bd}/celt/x86/vq_sse2.c ##
  ${bd}/celt/x86/x86_celt_map.c ##
  ${bd}/celt/x86/x86cpu.c ##
  )

include_directories(
  ${bd}/src
  ${bd}/silk
  ${bd}/silk/fixed
  ${bd}/silk/float
  ${bd}/celt
  ${bd}/include
  ${bd}/src
  ${bd}
  )

if (WIN32)
  include_directories(${bd}/win32/)
  add_definitions(-DHAVE_CONFIG_H)
endif()

add_library(opus STATIC ${opus_sources})
install(TARGETS opus ARCHIVE DESTINATION lib)
install(DIRECTORY ${bd}/include/ DESTINATION include/opus)

if (WIN32)
  # Generate version.h file
  execute_process(COMMAND git describe --tags OUTPUT_VARIABLE git_tag)
  string(STRIP ${git_tag} git_tag)
  file(WRITE ${bd}/win32/version.h "#define PACKAGE_VERSION \"${git_tag}\"")
endif()